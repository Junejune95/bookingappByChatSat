// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCarBookNowScreen extends StatefulWidget {
  const BookingCarBookNowScreen({Key? key}) : super(key: key);

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
  late MediaQueryData _mediaQueryData;

  List<BookingHistoryTab> pages = [
    BookingHistoryTab(
      title: Booking_lbl_Booking_book,
      child: BookWidget(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_enquiry,
      child: EnquiryWidget(),
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

  String _range = 'Select Date';

  String _rangeCount = '';

  bool isCheckInCalendar = false;

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
        height: context.height(),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Material(
          color: Booking_TextColorWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(
                title: Booking_lbl_CheckIn,
              ),
              10.height,
              Container(
                width: context.width(),
                padding: EdgeInsets.all(10),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Booking_TextColorSecondary.withOpacity(0.3),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Row(
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
                ),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    labelText(
                      title: 'Number',
                      color: Booking_Primary,
                    ),
                    CounterComponent(),
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
              ListView(
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: prices.keys.map((String key) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: prices[key],
                            onChanged: (bool? value) {
                              setState(() {
                                prices[key] = value! ? true : false;
                              });
                            },
                          ), //Checkbox
                          SizedBox(
                            width: 2,
                          ), //SizedBox
                          Text(
                            key,
                            style: TextStyle(fontSize: 16.0),
                          ), //Text //SizedBox
                          /** Checkbox Widget **/
                        ], //<Widget>[]
                      ),
                      labelText(title: '\$100', color: Booking_TextColorPrimary)
                    ],
                  );
                }).toList(),
              ),
              dividerWidget(color: Booking_greyColor),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Booking_lbl_fee1,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  labelText(title: '\$100', color: Booking_TextColorPrimary)
                ],
              ),
              26.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Booking_lbl_fee2,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  labelText(title: '\$100', color: Booking_TextColorPrimary)
                ],
              ),
              20.height,
              dividerWidget(color: Booking_greyColor),
              20.height,

              Center(
                child: defaultButton(
                  text: Booking_lbl_BookNow,
                  tap: () {},
                  height: 50,
                  width: 180,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EnquiryWidget extends StatelessWidget {
  EnquiryWidget({Key? key}) : super(key: key);

  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        color: context.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildNameField(),
                16.height,
                buildEmailField(),
                16.height,
                buildPhoneNumberField(),
                16.height,
                buildNoteField(),
                16.height,
                Center(
                  child: defaultButton(
                    text: Booking_lbl_SendNow,
                    tap: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    height: 50,
                    width: 180,
                  ),
                )
              ],
            )),
      ),
    );
  }

  AppTextField buildEmailField() {
    return AppTextField(
      controller: emailCont,
      textFieldType: TextFieldType.EMAIL,
      decoration: InputDecoration(
        hintText: 'Email Id',
        suffixIcon: Icon(Booking_ic_email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return Booking_err_txt_email_invalid;
        }
        return null;
      },
    );
  }

  AppTextField buildNameField() {
    return AppTextField(
      controller: nameCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_name1;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  AppTextField buildNoteField() {
    return AppTextField(
      controller: noteCont,
      textFieldType: TextFieldType.NAME,
      minLines: 4,
      maxLines: 4,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Note',
      ),
    );
  }

  AppTextField buildPhoneNumberField() {
    return AppTextField(
      controller: phoneCont,
      textFieldType: TextFieldType.PHONE,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Phone Number',
          suffixIcon: Icon(Booking_ic_phone),
          suffixIconColor: Booking_InputBorder),
    );
  }
}
