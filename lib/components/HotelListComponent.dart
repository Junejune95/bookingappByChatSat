// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HolelListComponent extends StatelessWidget {
  HolelListComponent({required this.isHome, Key? key, required this.hotellist})
      : super(key: key);

  final bool isHome;
  final List<BookingHotelModel> hotellist;

  @override
  Widget build(BuildContext context) {
    return isHome == true ? horizontalListWidget() : verticalListWidget();
  }

  Widget verticalListWidget() {
    return ListView.builder(
      itemCount: hotellist.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return defaultCard(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(hotellist[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ).cornerRadiusWithClipRRectOnly(topLeft: 10, topRight: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingComponent(
                          isIndicator: true,
                          rating: hotellist[index].rating,
                        ),
                        priceWrapper(
                          price: hotellist[index].price,
                          unit: 'night',
                          isFullScreen: true,
                        ),
                      ],
                    ),
                    12.height,
                    titleText(title: hotellist[index].name),
                    12.height,
                    locationWrapper(location: hotellist[index].location)
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  HorizontalList horizontalListWidget() {
    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: hotellist.length,
      itemBuilder: (context, index) {
        return defaultCard(
          width: 220,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.network(
                      hotellist[index].image,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(10),
                  ),
                  titleText(
                    title: hotellist[index].name,
                    size: 16,
                  ),
                  8.height,
                  locationWrapper(location: hotellist[index].location),
                  8.height,
                  priceWrapper(
                      price: hotellist[index].price,
                      unit: 'night',
                      isFullScreen: false),
                  10.height,
                ],
              ),
              Positioned(
                  top: 15,
                  right: 15,
                  child: const Icon(
                    Icons.favorite,
                    color: Booking_TextColorWhite,
                    size: 24,
                  ).onTap(() {})),
            ],
          ),
        );
      },
    );
  }
}
