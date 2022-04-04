// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/CounterComponent.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingFlightDetailScreen extends StatefulWidget {
  const BookingFlightDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingFlightDetailScreen> createState() => _BookingFlightDetailScreenState();
}

class _BookingFlightDetailScreenState extends State<BookingFlightDetailScreen> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Booking_app_Background,
      bottomNavigationBar: Container(
        height: context.height()/5.5,
        color: Booking_AppBar,
        padding: const EdgeInsets.symmetric(
          vertical: 30,
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
            20.height,
            defaultButton(
              text: Booking_lbl_BookNow,
              tap: () {},
              height: 40,
              width: 120
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(context),
              cardWidget(),
              cardWidget(),
              cardWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Container cardWidget() {
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
            value: 'First Class',
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(
            label: 'Baggage',
            value: 'Adult',
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(
            label: 'Check-in',
            value: '12 Kgs',
          ),
          dividerWidget(color: Booking_greyColor),
          rowWidget(label: 'Price', value: '\$11', isHighlight: true),
          dividerWidget(color: Booking_greyColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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

  Container headerWidget(BuildContext context) {
    return Container(
      color: Booking_AppBar,
      height: context.height() / 2.4,
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
                        title: 'SALLY CARTWRIGHT | VJ573',
                        width: context.width() / 2)
                  ],
                ),
                30.height,
                timeChartWidget(
                  ic: Booking_ic_takeof,
                  time: '20:54',
                  date: 'Wed, 09 Mar 22',
                  location: 'North Bethanymouth',
                ),
                30.height,
                timeChartWidget(
                  ic: Booking_ic_landing,
                  time: '20:54',
                  date: 'Wed, 09 Mar 22',
                  location: 'North Bethanymouth',
                ),
                30.height,
                timeWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row timeWidget() {
    return Row(
      children: [
        Icon(
          Booking_ic_time,
          size: 30,
          color: Booking_Secondary,
        ),
        20.width,
        titleText(
          title: '7 hr',
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
              'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/flight/airline/img1.jpg'),
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
