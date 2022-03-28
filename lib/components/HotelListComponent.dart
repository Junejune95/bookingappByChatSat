// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bookingapp/models/BookingCommonModel.dart';
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
    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: hotellist.length,
      itemBuilder: (context, index) {
        return Container(
          width: 220,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius(16),
            boxShadow: defaultBoxShadow(
              shadowColor: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              spreadRadius: 0.3,
            ),
          ),
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
                  priceWrapper(price: hotellist[index].price, unit: 'night'),
                  10.height,
                ],
              ),
                 Positioned(
                top: 15,
                right: 15,
                child:const Icon(
                  Icons.favorite,
                  color: Booking_TextColorWhite,
                  size: 24,
                ).onTap((){})
              ),
            ],
          ),
        );
      },
    );
  }
}
