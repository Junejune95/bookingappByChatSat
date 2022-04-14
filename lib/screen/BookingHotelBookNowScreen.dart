// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/screen/BookingEnquiryForm.dart';
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
  const BookingHotelBookNowScreen({Key? key}) : super(key: key);

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

  List<BookingHistoryTab> pages = [
    BookingHistoryTab(
      title: Booking_lbl_Booking_book,
      child: BookWidget(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_enquiry,
      child: BookingEnquiryForm(),
    ),
  ];

  @override
  void initState() {
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
  const BookWidget({Key? key}) : super(key: key);

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  Map<String, bool> prices = {
    Booking_lbl_Extra_Price1: false,
    Booking_lbl_Extra_Price2: false,
    Booking_lbl_Extra_Price3: false,
  };

  String _selectedDate = '';

  String _dateCount = '';

  String _range = Booking_lbl_CheckIn + ' / ' + Booking_lbl_CheckOut;

  String _rangeCount = '';

  bool isCheckInCalendar = false;
  bool isCheckGuest = false;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
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
                  checkResult: '1 Adult - 0 Child', onTap: () {
                setState(() {
                  isCheckGuest = !isCheckGuest;
                });
              }),
              if (isCheckGuest == true) guestWidget(),
              20.height,
              Center(
                child: defaultButton(
                  text: Booking_lbl_btn_CheckAvailability,
                  tap: () {},
                  height: 50,
                  width: context.width(),
                ),
              ),
              ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: defaultCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonCacheImageWidget(
                                    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/space/space-5.jpg',
                                    200,
                                    width: context.width())
                                .cornerRadiusWithClipRRectOnly(
                                    topLeft: 10, topRight: 10),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: titleText(
                                title: 'Room Kerama Islands',
                                size: 16,
                              ),
                            ),
                            Row(
                              children: [
                                iconColWidget(Booking_ic_measure, '196 sqt'),
                                iconColWidget(Booking_ic_bed, 'x5'),
                                iconColWidget(Booking_ic_people, 'x9'),
                                iconColWidget(Booking_ic_baby, 'x2'),
                              ],
                            ),
                            14.height,
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: tagrectWidget(
                                    isIcon: true,
                                    ic: Booking_ic_recycle,
                                    bgColor: Booking_greyColor,
                                    color: iconColorSecondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: tagrectWidget(
                                    isIcon: true,
                                    ic: Booking_ic_wifi,
                                    bgColor: Booking_greyColor,
                                    color: iconColorSecondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: tagrectWidget(
                                    isIcon: true,
                                    ic: Booking_ic_coffee,
                                    bgColor: Booking_greyColor,
                                    color: iconColorSecondary,
                                  ),
                                ),
                              ],
                            ),
                            10.height,
                          ],
                        ),
                      ),
                    );
                  })
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
              CounterComponent(),
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
              CounterComponent(),
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
