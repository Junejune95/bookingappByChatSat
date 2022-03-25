// ignore_for_file: constant_identifier_names

import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:flutter/material.dart';

enum AppMenu { HOME, HOTEL, CAR, FIGHT, MENU }
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
      case AppMenu.MENU:
        return "Menu";
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
      case AppMenu.MENU:
        return Booking_ic_menu;
      default:
        return null;
    }
  }
}

