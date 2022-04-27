// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/screen/BookingCheckoutScreen.dart';
import 'package:bookingapp/screen/BookingEnquiryForm.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCarBookNowScreen extends StatefulWidget {
  final int id;
  final List<BookingFeeModel> bookingfee, extrafee;
  const BookingCarBookNowScreen(
      {Key? key,
      required this.id,
      required this.extrafee,
      required this.bookingfee})
      : super(key: key);

  @override
  State<BookingCarBookNowScreen> createState() =>
      _BookingCarBookNowScreenState();
}

class BookingHistoryTab {
  String title;
  Widget child;

  BookingHistoryTab({required this.title, required this.child});
}

class _BookingCarBookNowScreenState extends State<BookingCarBookNowScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<BookingHistoryTab> pages = [];

  @override
  void initState() {
    pages = [
      BookingHistoryTab(
        title: Booking_lbl_Booking_book,
        child: BookWidget(
            bookingfee: widget.bookingfee,
            extrafee: widget.extrafee,
            id: widget.id),
      ),
      BookingHistoryTab(
        title: Booking_lbl_Booking_enquiry,
        child: BookingEnquiryForm(id: widget.id, type: 'car'),
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
  final List<BookingFeeModel> bookingfee, extrafee;
  final int id;
  const BookWidget(
      {Key? key,
      required this.bookingfee,
      required this.extrafee,
      required this.id})
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
  List<bool> _isChecked = [];

  String _selectedDate = '';
  String startDate = '';
  String endDate = '';

  String _dateCount = '';

  String _range = 'Select Date';

  String _rangeCount = '';

  bool isCheckInCalendar = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isChecked = List<bool>.filled(widget.extrafee.length, false);
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        print(args.value);
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        startDate = DateFormat('yyyy-MM-dd').format(args.value.startDate);
        endDate = DateFormat('yyyy-MM-dd')
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
    return Container(
      color: Booking_TextColorWhite,
      width: context.width(),
      height: context.height(),
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
            16.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  labelText(
                    title: 'Number',
                    color: Booking_Primary,
                  ),
                  CounterComponent(
                    callBack: (val) {},
                  ),
                ],
              ),
            ),
            //Row
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 16, top: 18),
              child: labelText(
                  title: Booking_lbl_Extra_Prices_title,
                  color: Booking_TextColorPrimary),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                  children: List.generate(
                      widget.extrafee.length,
                      (index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: <Widget>[
                                  Checkbox(
                                    value: _isChecked[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked[index] = value ?? false;
                                      });
                                    },
                                  ), //Checkbox
                                  SizedBox(
                                    width: 2,
                                  ), //SizedBox
                                  Text(
                                    widget.extrafee[index].name,
                                    style: TextStyle(fontSize: 16.0),
                                  ), //Text //SizedBox
                                  /** Checkbox Widget **/
                                ], //<Widget>[]
                              ),
                              labelText(
                                  title: '\$' + widget.extrafee[index].price,
                                  color: Booking_TextColorPrimary)
                            ],
                          ))),
            ),
            dividerWidget(color: Booking_greyColor),
            10.height,
            SizedBox(
              child: ListView.builder(
                itemCount: widget.bookingfee.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.bookingfee[index].name,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      labelText(
                          title: '\$' + widget.bookingfee[index].price,
                          color: Booking_TextColorPrimary)
                    ],
                  );
                },
              ),
              height: 70,
            ),

            dividerWidget(color: Booking_greyColor),
            20.height,
            Center(
              child: defaultButton(
                text: Booking_lbl_BookNow,
                tap: () async {
                  var response = await addToCart(widget.id, "car", startDate,
                      endDate, [], null, null, 1, []);
                  BookingCheckoutScreen(
                          startDate: startDate,
                          endDate: endDate,
                          totalPrice: 100.0,
                          choiceRoom: [],
                          adults: "1",
                          child: "0",
                          bookingCode: response)
                      .launch(context,
                          pageRouteAnimation:
                              PageRouteAnimation.SlideBottomTop);
                },
                height: 50,
                width: 180,
              ),
            )
          ],
        ),
      ),
    );
  }
}
