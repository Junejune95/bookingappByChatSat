// ignore_for_file: prefer_if_null_operators

import 'dart:ffi';

import 'package:bookingapp/size_config.dart';
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

Widget titleText(
    {required String title, int? size, int? maxLines, Color? color}) {
  return Text(
    title,
    style: boldTextStyle(
        decoration: TextDecoration.none,
        size: size != null ? size : 20,
        color: color != null ? color : Booking_TextColorPrimary),
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
    {required double price,
    bool? isHorizontal,
    double? iconSize,
    required String unit}) {
  return Row(
    children: [
     const Text(
        'From',
        style: TextStyle(
          color: Booking_TextColorSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
      8.width,
      Text(
        price.toString(),
        style: const TextStyle(
          color: Booking_TextColorBlue,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      8.width,

      Text(
        '/' + unit,
        style:const TextStyle(
          color: Booking_TextColorSecondary,
          // fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Container statusBoxWidget(String status, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(borderRadius: radius(8), color: color),
    child: Text(
      status,
      style: boldTextStyle(
        color: Booking_TextColorWhite,
        size: 12,
        decoration: TextDecoration.none,
      ),
    ),
  );
}

Divider dividerWidget({Color? color}) {
  return Divider(
    color: color != null ? color : Booking_TextColorWhite,
    height: 20,
    thickness: 1.5,
  );
}

Container defaultCard({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: radius(8),
      boxShadow: defaultBoxShadow(
        shadowColor: Booking_Primary.withOpacity(0.2),
        blurRadius: 4.0,
        spreadRadius: 0.3,
      ),
    ),
    child: child,
  );
}

Widget defaultButton(
    {Color? color,
    int? size,
    double? width,
    required String text,
    required VoidCallback tap}) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      width: width != null ? width : SizeConfig.screenWidth,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Booking_Secondary,
        borderRadius: radius(8),
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_Secondary.withOpacity(0.4),
          blurRadius: 4.0,
          spreadRadius: 0.3,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16,
            color: Booking_TextColorWhite,
            decoration: TextDecoration.none),
      ),
    ),
  );
}
