import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class BookingHistoryTab {
  String title;
  Widget child;

  BookingHistoryTab({required this.title, required this.child});
}

class _BookingHistoryState extends State<BookingHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late MediaQueryData _mediaQueryData;

  List<BookingHistoryTab> pages = [
    BookingHistoryTab(
      title: Booking_lbl_Booking_history1,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history2,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history3,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history4,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history5,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history6,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history7,
      child: bookingHistoryList(),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history8,
      child: bookingHistoryList(),
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
      length: 3,
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
              title: const Text('Booking History'),
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

Widget bookingHistoryList() {
  return Container(
    color: Booking_Primary_light,
    width: SizeConfig.screenWidth,
    padding: EdgeInsets.symmetric(vertical: 16,horizontal: 20),
    child: Column(
      children: [
        defaultCard(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
                child: Row(
                  children: [
                    Icon(Booking_ic_car),
                    8.width,
                    titleText(
                        title: 'Vinfast Lux A2.0 Plus',
                        size: 16,
                        color: Booking_TextColorBlue),
                    8.width,
                    statusBoxWidget('Processing', Booking_greenColor)
                  ],
                ),
              ),
              14.height,
              dataRowWidget('Order Date', '03/24/2022'),
              dividerWidget(color: Booking_greyColor),
              dataRowWidget('Total', '200'),
              dividerWidget(color: Booking_greyColor),
              dataRowWidget('Paid', '100'),
              dividerWidget(color: Booking_greyColor),
              dataRowWidget('Remain', '100'),
              footerCard()
            ],
          ),
        ),
      ],
    ),
  );
}

Container footerCard() {
  return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFECF2FC),
        borderRadius: radiusOnly(bottomLeft: 8, bottomRight: 8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          defaultButton(text: 'Detail', tap: () {}),
          16.width,
          defaultButton(text: 'Invoice', tap: () {}),
        ],
      ));
}

Widget dataRowWidget(lablename, data) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleText(
          title: lablename,
          size: 16,
        ),
        Text(
          data,
          style: const TextStyle(
            color: Booking_TextColorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    ),
  );
}
