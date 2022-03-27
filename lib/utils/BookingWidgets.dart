// ignore_for_file: prefer_if_null_operators

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget headerText({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      50.height,
      Text(title, style: boldTextStyle(size: 30, color: white)),
      16.height,
    ],
  );
}

Widget titleText({required String title, int? size, int? maxLines}) {
  return Text(
    title,
    style: boldTextStyle(
        size: size != null ? size : 20, color: Booking_TextColorPrimary),
    maxLines: maxLines != null ? maxLines : 1,
    overflow: TextOverflow.ellipsis,
  );
}

Widget descriptionText(
    {required String description, int? size, int? maxLines}) {
  return Text(
    description,
    style: boldTextStyle(
        size: size != null ? size : 12, color: Booking_TextColorSecondary),
    maxLines: maxLines != null ? maxLines : 1,
    overflow: TextOverflow.ellipsis,
  );
}

Widget locationWrapper(
    {required String location, int? size, double? iconSize, Color? color}) {
  return Row(
    children: [
      Icon(Booking_ic_location,
          size: iconSize != null ? iconSize : 16,
          color: color != null ? color : iconColorSecondary),
      Text(
        location,
        style: boldTextStyle(
            size: size != null ? size : 14, color: Booking_TextColorSecondary),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}


Widget priceWrapper(
    {required double price, bool? isHorizontal, double? iconSize}) {
  return Row(
    children: [
      Text('From'),
      Text(
        price.toString(),
        style:const TextStyle(
          color: Booking_TextColorBlue,
          fontSize: 14,
          fontWeight: FontWeight.w500
        )
      )
    ],
  );
}