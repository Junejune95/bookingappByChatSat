// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/screen/BookingFlightDetailScreen.dart';
import 'package:bookingapp/services/flight.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loadmore/loadmore.dart';
import 'package:nb_utils/nb_utils.dart';

class FlightListComponent extends StatefulWidget {
  FlightListComponent({Key? key, required this.flightlist}) : super(key: key);

  final List<FlightModel> flightlist;
  @override
  State<FlightListComponent> createState() => _FlightListComponentState();
}

class _FlightListComponentState extends State<FlightListComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.flightlist.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return defaultCard(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: commonCacheImageWidget(
                        widget.flightlist[index].image, 0),
                  ).cornerRadiusWithClipRRect(10),
                ),
                10.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleText(
                          title: widget.flightlist[index].airport_from,
                          width: context.width() / 3),
                      priceWrapper(
                          price: widget.flightlist[index].price,
                          unit: 'avg/person',
                          isFullScreen: true,
                          isFromText: false),
                    ],
                  ),
                ),
                20.height,
                commonWidget(Booking_ic_takeof, Booking_lbl_Take_Off,
                    widget.flightlist[index].departuretime),
                26.height,
                commonWidget(Booking_ic_landing, Booking_lbl_Landing,
                    widget.flightlist[index].arrivaltime),
                28.height,
                InkWell(
                  onTap: () => {
                    BookingFlightDetailScreen(
                      id: widget.flightlist[index].id,
                    ).launch(context,
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

  Future<bool> _loadMore() async {
    print("onLoadMore");
    List<FlightModel> moreFlights = await getFlightData("");
    widget.flightlist.addAll(moreFlights);
    return true;
  }

  Widget commonWidget(ic, label, String time) {
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
                title: DateFormat('EEE MMM d hh:m:s a')
                    .format(DateTime.parse(time)),
                size: textSizeLargeMedium.toInt(),
              )
            ],
          )
        ],
      ),
    );
  }
}
