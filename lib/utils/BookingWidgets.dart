// ignore_for_file: prefer_if_null_operators

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget titleText({required String title, int? size, int? maxLines}) {
  return Text(
    title,
    style: boldTextStyle(
        size: size != null ? size : 22, color: Booking_TextColorPrimary),
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
