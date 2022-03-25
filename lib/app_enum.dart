import 'package:flutter/material.dart';

enum AppMenu { HOME, HOTEL, CAR, FIGHT, MENU }

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
        return Icons.home;
      case AppMenu.HOTEL:
        return Icons.hotel;
      case AppMenu.CAR:
        return Icons.car_rental;
      case AppMenu.FIGHT:
        return Icons.flight;
      case AppMenu.MENU:
        return Icons.menu;
      default:
        return null;
    }
  }
}

