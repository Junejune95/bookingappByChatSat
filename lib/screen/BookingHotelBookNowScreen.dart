import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/HotelRoomModel.dart';
import 'package:bookingapp/screen/BookingCheckoutScreen.dart';
import 'package:bookingapp/screen/BookingEnquiryForm.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingHotelBookNowScreen extends StatefulWidget {
  final List<BookingFeeModel> extra_price, booking_fee;
  const BookingHotelBookNowScreen(
      {Key? key, required this.extra_price, required this.booking_fee})
      : super(key: key);

  @override
  State<BookingHotelBookNowScreen> createState() =>
      _BookingHotelBookNowScreenState();
}

class BookingHistoryTab {
  String title;
  Widget child;

  BookingHistoryTab({required this.title, required this.child});
}

class _BookingHotelBookNowScreenState extends State<BookingHotelBookNowScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<BookingHistoryTab> pages = [];

  @override
  void initState() {
    pages = [
      BookingHistoryTab(
        title: Booking_lbl_Booking_book,
        child: BookWidget(
          extra_price: widget.extra_price,
          booking_fee: widget.booking_fee,
        ),
      ),
      BookingHistoryTab(
        title: Booking_lbl_Booking_enquiry,
        child: BookingEnquiryForm(
          id: 1,
          type: 'hotel',
        ),
      ),
    ];
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              pinned: true,
              bottom: TabBar(
                  isScrollable: true,
                  controller: tabController,
                  labelColor: Booking_TextColorPrimary,
                  labelStyle: boldTextStyle(),
                  indicatorColor: Booking_Primary,
                  labelPadding: EdgeInsets.symmetric(horizontal: 50),
                  tabs: pages
                      .map<Tab>(
                        (e) => Tab(
                          text: e.title,
                        ),
                      )
                      .toList()),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: pages.map((e) => e.child).toList(),
        ),
      ),
    );
  }
}

class BookWidget extends StatefulWidget {
  final List<BookingFeeModel> extra_price, booking_fee;
  const BookWidget(
      {Key? key, required this.extra_price, required this.booking_fee})
      : super(key: key);

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  Map<String, bool> prices = {
    Booking_lbl_Extra_Price1: false,
    Booking_lbl_Extra_Price2: false,
    Booking_lbl_Extra_Price3: false,
  };
  late Future<List<HotelRoomModel>> hotelRoomModelList;
  String _selectedDate = '';

  String _dateCount = '';

  String _range = Booking_lbl_CheckIn + ' / ' + Booking_lbl_CheckOut;

  String _rangeCount = '';
  String adult = '1';
  String child = '0';
  String params = '?';
  String start_date = '', end_date = '';
  bool isCheckInCalendar = false;
  bool isCheckGuest = false;
  bool toBook = false;
  var dpList = <String?>[];
  @override
  void initState() {
    hotelRoomModelList = checkHotelAvaliable('10', params);
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        start_date = DateFormat('yyyy-MM-dd').format(args.value.startDate);
        end_date = DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate);
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Booking_TextColorWhite,
        width: context.width(),
        // height: context.height(),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Material(
          color: Booking_TextColorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextBoxFieldWidget(context, checkResult: _range, onTap: () {
                setState(() {
                  isCheckInCalendar = !isCheckInCalendar;
                });
              }),
              if (isCheckInCalendar == true)
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(
                      DateTime.now().subtract(const Duration(days: 4)),
                      DateTime.now().add(const Duration(days: 3))),
                ),
              if (isCheckInCalendar == false) 20.height,
              customTextBoxFieldWidget(context,
                  checkResult: '$adult Adult - $child Child', onTap: () {
                setState(() {
                  isCheckGuest = !isCheckGuest;
                });
              }),
              if (isCheckGuest == true) guestWidget(),
              20.height,
              Center(
                child: defaultButton(
                  text: Booking_lbl_btn_CheckAvailability,
                  tap: () {
                    setState(() {
                      hotelRoomModelList = checkHotelAvaliable('10',
                          '?start_date=$start_date&end_date=$end_date&adults=$adult&children=$child');
                    });
                  },
                  height: 50,
                  width: context.width(),
                ),
              ),
              FutureBuilder<List<HotelRoomModel>?>(
                  future: hotelRoomModelList,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      // return SpinKitFadingFour(color: Colors.green);
                      default:
                        if (snapshot.hasError)
                          // ignore: curly_braces_in_flow_control_structures
                          return Text('Error: ${snapshot.error}');
                        else {
                          List<HotelRoomModel>? data = snapshot.data;
                          data != null ? dpList.length = data.length : "";
                          return data != null
                              ? ListView.builder(
                                  itemCount: data.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: defaultCard(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonCacheImageWidget(
                                                    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/space/space-5.jpg',
                                                    200,
                                                    width: context.width())
                                                .cornerRadiusWithClipRRectOnly(
                                                    topLeft: 10, topRight: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: titleText(
                                                title: data[index].title,
                                                size: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                iconColWidget(
                                                    Booking_ic_measure,
                                                    data[index].size),
                                                iconColWidget(Booking_ic_bed,
                                                    data[index].beds),
                                                iconColWidget(Booking_ic_people,
                                                    data[index].adults),
                                                iconColWidget(Booking_ic_baby,
                                                    data[index].children),
                                              ],
                                            ),
                                            14.height,
                                            SizedBox(
                                              child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: data[index]
                                                      .facilitylist
                                                      ?.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                        ),
                                                        child: tagrectWidget(
                                                          isIcon: true,
                                                          ic: data[index]
                                                              .facilitylist?[i]
                                                              .icon,
                                                          bgColor:
                                                              Booking_greyColor,
                                                          color:
                                                              iconColorSecondary,
                                                        ));
                                                  }),
                                              height: 60,
                                            ),
                                            if (data[index]
                                                .price_list!
                                                .isNotEmpty)
                                              DropdownButton<String>(
                                                items: data[index]
                                                    .price_list!
                                                    .map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                value: dpList[index] != null
                                                    ? dpList[index]
                                                    : null,
                                                onChanged: (val) {
                                                  dpList.insert(index, val!);
                                                  setState(() {
                                                    dpList;
                                                    toBook = true;
                                                    print(dpList);
                                                  });
                                                },
                                              ),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(
                                            //       child: ListView.builder(
                                            //           physics:
                                            //               const NeverScrollableScrollPhysics(),
                                            //           shrinkWrap: true,
                                            //           itemCount: data[index]
                                            //               .facilitylist
                                            //               ?.length,
                                            //               scrollDirection: Axis.horizontal,
                                            //           itemBuilder:
                                            //               (context, i) {
                                            //             return Padding(
                                            //                 padding:
                                            //                     const EdgeInsets
                                            //                         .symmetric(
                                            //                   horizontal: 10,
                                            //                 ),
                                            //                 child:
                                            //                     tagrectWidget(
                                            //                   isIcon: true,
                                            //                   ic: data[index]
                                            //                       .facilitylist?[
                                            //                           i]
                                            //                       .icon,
                                            //                   bgColor:
                                            //                       Booking_greyColor,
                                            //                   color:
                                            //                       iconColorSecondary,
                                            //                 ));
                                            //           }),
                                            //       height: 100,
                                            //     )
                                            //     // Padding(
                                            //     //   padding: const EdgeInsets
                                            //     //       .symmetric(
                                            //     //     horizontal: 10,
                                            //     //   ),
                                            //     //   child: tagrectWidget(
                                            //     //     isIcon: true,
                                            //     //     ic: Booking_ic_recycle,
                                            //     //     bgColor: Booking_greyColor,
                                            //     //     color: iconColorSecondary,
                                            //     //   ),
                                            //     // ),
                                            //     // Padding(
                                            //     //   padding: const EdgeInsets
                                            //     //       .symmetric(
                                            //     //     horizontal: 10,
                                            //     //   ),
                                            //     //   child: tagrectWidget(
                                            //     //     isIcon: true,
                                            //     //     ic: Booking_ic_wifi,
                                            //     //     bgColor: Booking_greyColor,
                                            //     //     color: iconColorSecondary,
                                            //     //   ),
                                            //     // ),
                                            //     // Padding(
                                            //     //   padding: const EdgeInsets
                                            //     //       .symmetric(
                                            //     //     horizontal: 10,
                                            //     //   ),
                                            //     //   child: tagrectWidget(
                                            //     //     isIcon: true,
                                            //     //     ic: Booking_ic_coffee,
                                            //     //     bgColor: Booking_greyColor,
                                            //     //     color: iconColorSecondary,
                                            //     //   ),
                                            //     // ),
                                            //   ],
                                            // ),
                                            10.height,
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : Container(
                                  child: const Text(" No Data Exist "),
                                );
                        }
                    }
                  }),
              if (toBook)
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.extra_price.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      value: false,
                                      onChanged: (bool? value) {
                                        setState(() {});
                                      },
                                    ),
                                    Text(widget.extra_price[i].name +
                                        " " +
                                        "\$" +
                                        widget.extra_price[i].price)
                                  ],
                                );
                              }),
                          height: 60,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Total rooms 10"),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Service Fee \$" + widget.booking_fee[0].price))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Total Price \$1500"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: defaultButton(
                          text: Booking_lbl_BookNow,
                          tap: () async {
                            await addToCart();
                            const BookingCheckoutScreen().launch(context,
                                pageRouteAnimation:
                                    PageRouteAnimation.SlideBottomTop);
                          },
                          height: 40,
                          width: 120),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Padding iconColWidget(ic, text) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          tagrectWidget(
            isIcon: true,
            ic: ic,
          ),
          labelText(
            title: text,
            color: Booking_TextColorPrimary,
            size: 14,
          )
        ],
      ),
    );
  }

  Container guestWidget() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Booking_TextColorSecondary.withOpacity(0.3),
          style: BorderStyle.solid,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelText(
                title: Booking_lbl_Booking_children,
                color: Booking_Primary,
              ),
              CounterComponent(
                callBack: (val) {
                  setState(() {
                    adult = val;
                  });
                },
              ),
            ],
          ),
          30.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              labelText(
                title: Booking_lbl_Booking_adults,
                color: Booking_Primary,
              ),
              CounterComponent(
                callBack: (val) {
                  setState(() {
                    child = val;
                    params += '&adults=$child';
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row checkInOutWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _range,
          style: TextStyle(
            fontSize: 14,
            color: Booking_TextColorPrimary,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isCheckInCalendar = !isCheckInCalendar;
            });
          },
          child: Icon(
            Booking_ic_calendar,
            size: 24,
            color: Booking_TextColorSecondary,
          ),
        )
      ],
    );
  }
}
