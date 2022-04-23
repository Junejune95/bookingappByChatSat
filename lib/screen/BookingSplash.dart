// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bookingapp/main.dart';
import 'package:bookingapp/screen/BookingWalkThroughScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingSplash extends StatefulWidget {
  static String tag = '/BankingSplash';

  @override
  _BookingSplashState createState() => _BookingSplashState();
}

class _BookingSplashState extends State<BookingSplash> {
  void initState() {
    setStatusBarColor(Booking_Primary);
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    setState(
      () {
        finish(context);
        BookingWalkThrough().launch(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BookingLogo),
                fit: BoxFit.contain,
              ),
            ),
          )),
    );
  }
}
