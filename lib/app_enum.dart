// ignore_for_file: constant_identifier_names

import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:flutter/material.dart';

enum AppMenu { HOME, HOTEL, CAR, FIGHT, MORE }
enum SortBy { Recommended, PriceLowToHigh,PriceHighToLow, RatingLowToHigh }

extension AppMenuExtension on AppMenu {
  String? get appLabelMenu {
    switch (this) {
      case AppMenu.HOME:
        return "Home";
      case AppMenu.HOTEL:
        return "Hotel";
      case AppMenu.CAR:
        return "Car";
      case AppMenu.FIGHT:
        return "Fight";
      case AppMenu.MORE:
        return "MORE";
      default:
        return null;
    }
  }

  IconData? get appMenuIcon {
   switch (this) {
      case AppMenu.HOME:
        return Booking_ic_home;
      case AppMenu.HOTEL:
        return Booking_ic_hotel;
      case AppMenu.CAR:
        return Booking_ic_car;
      case AppMenu.FIGHT:
        return Booking_ic_fight;
      case AppMenu.MORE:
        return Booking_ic_more;
      default:
        return null;
    }
  }
}

