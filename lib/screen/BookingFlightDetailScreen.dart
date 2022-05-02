// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/screen/BookingCheckoutScreen.dart';
import 'package:bookingapp/services/flight.page.service.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

late Future<FlightModel?> flightModel;

class BookingFlightDetailScreen extends StatefulWidget {
  final int id;
  const BookingFlightDetailScreen({Key? key, required this.id})
      : super(key: key);

  @override
  State<BookingFlightDetailScreen> createState() =>
      _BookingFlightDetailScreenState();
}

class _BookingFlightDetailScreenState extends State<BookingFlightDetailScreen> {
  int _itemCount = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightModel = getFlightDetail(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Booking_app_Background,
      bottomNavigationBar: Container(
        height: context.height() / 5.5,
        color: Booking_AppBar,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText(title: 'Pay Amount'),
                titleText(title: '99'),
              ],
            ),
            12.height,
            defaultButton(
                text: Booking_lbl_BookNow,
                tap: () async {
                  var response = await addToCart(
                      widget.id,
                      "flight",
                      "",
                      "endDate",
                      [],
                      null,
                      null,
                      1,
                      [],
                      [
                        {
                          "max_passenger": 17,
                          "person": "adult",
                          "number": 1,
                          "price": 30
                        }
                      ]);
                  BookingCheckoutScreen(
                          startDate: "2022-03-11T05:58:50.000000Z",
                          endDate: "2022-03-11T05:58:50.000000Z",
                          totalPrice: 100.0,
                          choiceRoom: [],
                          adults: "1",
                          child: "0",
                          bookingCode: response)
                      .launch(context,
                          pageRouteAnimation:
                              PageRouteAnimation.SlideBottomTop);
                },
                height: 40,
                width: 120),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<FlightModel?>(
              future: flightModel,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError)
                      // ignore: curly_braces_in_flow_control_structures
                      return Text('Error: ${snapshot.error}');
                    else {
                      FlightModel? data = snapshot.data;
                      return data != null
                          ? Column(
                              children: [
                                headerWidget(context, data),
                                ListView.builder(
                                    itemCount: data.seats?.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return cardWidget(
                                          data.seats![index].seat_type,
                                          data.seats![index].person,
                                          data.seats![index].baggage_check_in,
                                          data.seats![index].price);
                                    }),
                              ],
                            )
                          : Container(
                              child: const Text(" No Data Exist "),
                            );
                    }
                }
              }),
        ),
      ),
    );
  }

  Container cardWidget(
      String seatType, String person, String check_in, double price) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius(8),
          border: Border.all(
            color: Booking_LineColor,
            style: BorderStyle.solid,
            width: 0.80,
          )),
      child: Column(
        children: [
          8.height,
          rowWidget(
            label: 'Seat Type',
            value: seatType,
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(
            label: 'Baggage',
            value: person,
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(
            label: 'Check-in',
            value: check_in,
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(
              label: 'Price',
              value: '\$' + price.toString(),
              isHighlight: true),
          dividerWidget(color: Booking_greyColor),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
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
          8.height,
        ],
      ),
    );
  }

  Padding rowWidget(
      {required String label, required String value, bool? isHighlight}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelText(
            title: label,
            color: Booking_Primary,
          ),
          Text(
            value,
            style: TextStyle(
              color: isHighlight == true ? Booking_Secondary : Booking_Primary,
              fontWeight:
                  isHighlight == true ? FontWeight.bold : FontWeight.w500,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Container headerWidget(BuildContext context, FlightModel flightModel) {
    return Container(
      color: Booking_AppBar,
      height: context.height() / 2,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GestureDetector(
                child: Icon(Icons.arrow_back_ios),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ),
            16.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    flightLogoWidget(),
                    16.width,
                    titleText(
                        title: flightModel.title, width: context.width() / 2)
                  ],
                ),
                20.height,
                timeChartWidget(
                  ic: Booking_ic_takeof,
                  time: flightModel.departuretime.isNotEmpty
                      ? DateFormat("hh:mm")
                          .format(DateTime.parse(flightModel.departuretime))
                      : "",
                  date: flightModel.departuretime.isNotEmpty
                      ? DateFormat('EEE, MMM d yy')
                          .format(DateTime.parse(flightModel.departuretime))
                      : "",
                  location: flightModel.airport_from,
                ),
                10.height,
                timeChartWidget(
                  ic: Booking_ic_landing,
                  time: flightModel.arrivaltime.isNotEmpty
                      ? DateFormat("hh:mm")
                          .format(DateTime.parse(flightModel.arrivaltime))
                      : "",
                  date: flightModel.arrivaltime.isNotEmpty
                      ? DateFormat('EEE, MMM d yy')
                          .format(DateTime.parse(flightModel.arrivaltime))
                      : "",
                  location: flightModel.airport_to,
                ),
                10.height,
                timeWidget(flightModel.duration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row timeWidget(String duration) {
    return Row(
      children: [
        Icon(
          Booking_ic_time,
          size: 30,
          color: Booking_Secondary,
        ),
        20.width,
        titleText(
          title: duration + ' hr',
          size: textSizeLargeMedium.toInt(),
        ),
      ],
    );
  }

  Widget timeChartWidget(
      {required String time,
      required String date,
      required String location,
      required IconData ic}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          ic,
          size: 30,
          color: Booking_Secondary,
        ),
        20.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            titleText(title: time, size: textSizeLargeMedium.toInt()),
            14.height,
            Text(
              'Wed, 09 Mar 22',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Booking_TextColorSecondary,
                  fontSize: textSizeMedium),
            ),
            14.height,
            Text(
              'North Bethanymouth',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Booking_TextColorSecondary,
                  fontSize: textSizeMedium),
            ),
          ],
        ),
      ],
    );
  }

  Container flightLogoWidget() {
    return Container(
      width: 80,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://booking.hiyan.xyz/uploads/demo/flight/airline/img1.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_TextColorSecondary.withOpacity(0.2),
          blurRadius: 4.0,
          spreadRadius: 0.4,
        ),
      ),
    );
  }
}
