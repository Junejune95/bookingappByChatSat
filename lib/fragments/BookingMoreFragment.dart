// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingMoreFragment extends StatelessWidget {
  const BookingMoreFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Booking_Secondary,
          child: Column(
            children: [
              upperContainer(),
              10.height,
              itemWidget(
                Booking_lbl_My_profile,
                Booking_ic_person,
                () {},
              ),
              dividerWidget(),
              itemWidget(
                Booking_lbl_Booking_history,
                Booking_ic_history,
                () {},
              ),
              dividerWidget(),
              itemWidget(
                Booking_lbl_Change_password,
                Booking_ic_lock,
                () {},
              ),
              dividerWidget(),
              itemWidget(
                Booking_lbl_Setting,
                Booking_ic_setting,
                () {},
              ),
              dividerWidget(),
              itemWidget(
                Booking_lbl_Log_out,
                Booking_ic_logout,
                () {},
              ),
              dividerWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Divider dividerWidget() {
    return Divider(
              color: Booking_TextColorWhite,
              height: 20,
              thickness: 1.5,
            );
  }

  SettingItemWidget itemWidget(String label, IconData icon, Function press) {
    return SettingItemWidget(
        title: label,
        leading: Icon(icon, color: Booking_TextColorWhite, size: 20),
        titleTextStyle: boldTextStyle(size: 18, color: Booking_TextColorWhite),
        onTap: press);
  }

  Container upperContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Booking_Primary_light,
      child: Row(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80")),
            ),
          ),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              statusBoxWidget('Customer', Booking_greenColor),
              8.height,
              Text(
                'User Name',
                style: TextStyle(
                  color: Booking_TextColorPrimary,
                  fontSize: textSizeLargeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              6.height,
              Text(
                'Member Since Mar 2022',
                style: TextStyle(
                  color: Booking_TextColorSecondary,
                  fontSize: textSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.height,
              statusBoxWidget('Become a vendor', Booking_orangeColor),
            ],
          )
        ],
      ),
    );
  }

  Container statusBoxWidget(String status, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(borderRadius: radius(8), color: color),
      child: Text(
        status,
        style: boldTextStyle(color: Booking_TextColorWhite, size: 12),
      ),
    );
  }
}
