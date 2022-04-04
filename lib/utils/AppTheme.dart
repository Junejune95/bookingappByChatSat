// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Booking_app_Background,
    primaryColor: Booking_Primary,
    primaryColorDark: Booking_Primary,
    errorColor: Colors.red,
    hoverColor: Colors.white54,
    dividerColor: Booking_LineColor,
    fontFamily: 'Source Sans Pro',
    inputDecorationTheme: inputDecorationTheme(),

    appBarTheme: const AppBarTheme(
      color: Booking_AppBar,
      iconTheme: IconThemeData(color: Booking_TextColorPrimary),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Booking_TextColorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
    ),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    colorScheme: const ColorScheme.light(
        primary: Booking_Primary, primaryVariant: Booking_Primary),
    cardTheme: const CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: Booking_TextColorPrimary),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Booking_TextColorWhite),
    textTheme: const TextTheme(
      button: TextStyle(color: Booking_TextColorPrimary),
      headline6: TextStyle(color: Booking_TextColorPrimary),
      subtitle2: TextStyle(color: Booking_TextColorSecondary),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
        }),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColorDark,
    highlightColor: appBackgroundColorDark,
    errorColor: const Color(0xFFCF6676),
    appBarTheme: const AppBarTheme(
      color: appBackgroundColorDark,
      iconTheme: IconThemeData(color: color_primary_black),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: color_primary_black,
    dividerColor: const Color(0xFFDADADA).withOpacity(0.3),
    primaryColorDark: color_primary_black,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    hoverColor: Colors.black12,
    fontFamily: GoogleFonts.openSans().fontFamily,
    inputDecorationTheme: inputDecorationTheme(),

    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: appBackgroundColorDark),
    primaryTextTheme: TextTheme(
        headline6: primaryTextStyle(color: Colors.white),
        overline: primaryTextStyle(color: Colors.white)),
    cardTheme: const CardTheme(color: cardBackgroundBlackDark),
    cardColor: appSecondaryBackgroundColor,
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      button: TextStyle(color: color_primary_black),
      headline6: TextStyle(color: whiteColor),
      subtitle2: TextStyle(color: Colors.white54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.dark(
            primary: appBackgroundColorDark,
            onPrimary: cardBackgroundBlackDark,
            primaryVariant: color_primary_black)
        .copyWith(secondary: whiteColor),
  ).copyWith(
    pageTransitionsTheme:
        PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );
}


InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  BorderSide(color: Booking_LineColor),
    gapPadding: 10,
  );
    OutlineInputBorder focusoutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:  BorderSide(color: Booking_Primary),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    enabledBorder: outlineInputBorder,
    focusedBorder: focusoutlineInputBorder,
    border: outlineInputBorder,
    suffixIconColor: Booking_InputBorder,
    focusColor: Booking_Primary
  );
}