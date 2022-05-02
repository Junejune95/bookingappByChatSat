import 'package:bookingapp/models/BookingHisModel.dart';
import 'package:bookingapp/services/user.service.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

late Future<List<BookingHis>> allbooking,
    compelete,
    process,
    confirm,
    cancel,
    paid,
    unpaid,
    partial;

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class BookingHistoryTab {
  String title;
  Widget child;

  BookingHistoryTab({
    required this.title,
    required this.child,
  });
}

class _BookingHistoryState extends State<BookingHistory>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late MediaQueryData _mediaQueryData;

  List<BookingHistoryTab> pages = [
    BookingHistoryTab(
      title: Booking_lbl_Booking_history1,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history2,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history3,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history4,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history5,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history6,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history7,
      child: bookingHistoryList(null),
    ),
    BookingHistoryTab(
      title: Booking_lbl_Booking_history8,
      child: bookingHistoryList(null),
    ),
  ];

  @override
  void initState() {
    allbooking = userBookingHis("");
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
    tabController.addListener(() {
      print("on change " + pages[tabController.index].title);
      setState(() {
        pages[tabController.index].title == Booking_lbl_Booking_history1
            ? allbooking = userBookingHis("")
            : pages[tabController.index].title == Booking_lbl_Booking_history2
                ? allbooking = userBookingHis("completed")
                : pages[tabController.index].title ==
                        Booking_lbl_Booking_history3
                    ? allbooking = userBookingHis("processing")
                    : pages[tabController.index].title ==
                            Booking_lbl_Booking_history4
                        ? allbooking = userBookingHis("confirmed")
                        : pages[tabController.index].title ==
                                Booking_lbl_Booking_history5
                            ? allbooking = userBookingHis("cancelled")
                            : pages[tabController.index].title ==
                                    Booking_lbl_Booking_history6
                                ? allbooking = userBookingHis("paid")
                                : pages[tabController.index].title ==
                                        Booking_lbl_Booking_history7
                                    ? allbooking = userBookingHis("unpaid")
                                    : allbooking =
                                        userBookingHis("partial_payment");
      });
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
          children: pages
              .map(
                (e) => Container(
                    color: Booking_Primary_light,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          FutureBuilder<List<BookingHis>>(
                              future: allbooking,
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  default:
                                    if (snapshot.hasError)
                                      // ignore: curly_braces_in_flow_control_structures
                                      return Text('Error: ${snapshot.error}');
                                    else {
                                      List<BookingHis>? data = snapshot.data;
                                      // selectedOne = null;
                                      return data != null && data.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: data.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return bookingHistoryList(
                                                    data[index]);
                                              },
                                            )
                                          : Container(
                                              child:
                                                  const Text(" No Data Exist "),
                                            );
                                    }
                                }
                              }),
                        ],
                      ),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}

Widget bookingHistoryList(BookingHis? bookingHis) {
  return bookingHis != null
      ? Container(
          color: Booking_Primary_light,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              defaultCard(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 16),
                      child: Row(
                        children: [
                          Icon(Booking_ic_car),
                          8.width,
                          titleText(
                              title: bookingHis.serviceTitle,
                              size: 16,
                              color: Booking_TextColorBlue),
                          8.width,
                          statusBoxWidget(bookingHis.status, Booking_greenColor)
                        ],
                      ),
                    ),
                    14.height,
                    dataRowWidget(
                        'Order Date',
                        DateFormat("DD/MM/yyyy")
                            .format(DateTime.parse(bookingHis.start_date))),
                    dividerWidget(color: Booking_greyColor),
                    dataRowWidget('Total', bookingHis.total),
                    dividerWidget(color: Booking_greyColor),
                    dataRowWidget('Paid', bookingHis.paid),
                    dividerWidget(color: Booking_greyColor),
                    dataRowWidget('Remain', bookingHis.total),
                    footerCard()
                  ],
                ),
              ),
            ],
          ),
        )
      : Container(
          child: Text("Data is processing"),
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
