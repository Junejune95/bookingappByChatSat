// ignore_for_file: prefer_if_null_operators, prefer_const_constructors

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';

typedef intCallBack(int val);

class RatingComponent extends StatelessWidget {
  RatingComponent(
      {Key? key,
      required this.isIndicator,
      this.label,
      this.rating,
      this.callback,
      this.iconSize = 22})
      : super(key: key);

  final bool isIndicator;
  final String? label;
  final double? rating;
  final intCallBack? callback;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return isIndicator
        ? ratingIndicator(rating, iconSize)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText(title: label!),
              10.height,
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: Color(0xFFFFCFC6),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemSize: iconSize != null ? iconSize : 22,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Booking_OrangeDarkColor,
                ),
                onRatingUpdate: (rating) {
                  callback!(rating.toInt());
                },
              ),
            ],
          );
  }
}

Widget ratingIndicator(rating, iconSize) {
  return RatingBarIndicator(
    rating: rating,
    unratedColor: Color(0xFFFFCFC6),
    itemSize: iconSize != null ? iconSize : 22,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: Booking_OrangeDarkColor,
    ),
    itemCount: 5,
    direction: Axis.horizontal,
  );
}
