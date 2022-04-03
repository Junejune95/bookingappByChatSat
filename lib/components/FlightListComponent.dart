// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/screen/FlightDetailScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FlightListComponent extends StatelessWidget {
  FlightListComponent({Key? key, required this.flightlist}) : super(key: key);

  final List<FlightModel> flightlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: flightlist.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return defaultCard(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image.network(
                      'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/flight/airline/img1.jpg',
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(8),
                  ),
                ),
                10.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(
                          title: flightlist[index].title,
                          width: context.width() / 3),
                      priceWrapper(
                          price: flightlist[index].price,
                          unit: 'avg/person',
                          isFullScreen: true,
                          isFromText: false),
                    ],
                  ),
                ),
                20.height,
                commonWidget(Booking_ic_takeof, Booking_lbl_Take_Off),
                26.height,
                commonWidget(Booking_ic_landing, Booking_lbl_Landing),
                28.height,
                InkWell(
                  onTap: () => {
                    FlightDetailScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.SlideBottomTop)
                  },
                  child: Container(
                    width: context.width(),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Booking_Secondary,
                      borderRadius: radiusOnly(bottomLeft: 8, bottomRight: 8),
                    ),
                    child: titleText(
                      title: 'CHOOSE',
                      color: Booking_TextColorWhite,
                      size: textSizeLargeMedium.toInt(),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget commonWidget(ic, label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ic,
            size: 28,
            color: Booking_Secondary,
          ),
          10.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                label,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Booking_TextColorSecondary,
                    fontSize: textSizeMedium),
              ),
              10.height,
              titleText(
                title: 'Wed Mar 09 20:54 PM',
                size: textSizeLargeMedium.toInt(),
              )
            ],
          )
        ],
      ),
    );
  }
}
