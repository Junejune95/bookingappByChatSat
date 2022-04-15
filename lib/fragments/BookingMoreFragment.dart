// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/screen/BookingHistoryScreen.dart';
import 'package:bookingapp/screen/BookingSignInScreen.dart';
import 'package:bookingapp/screen/BookingUserInformationScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingMoreFragment extends StatelessWidget {
  BookingMoreFragment({Key? key}) : super(key: key);

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Booking_Primary,
            child: isLogin == true
                ? afteruserloginWidget(context)
                : BookingSignInScreen()),
      ),
    );
  }

  Column afteruserloginWidget(BuildContext context) {
    return Column(
      children: [
        upperContainer(),
        10.height,
        itemWidget(
          Booking_lbl_My_profile,
          Booking_ic_person,
          () {
            BookingUserInformationScreen().launch(context,pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
          },
        ),
        dividerWidget(),
        itemWidget(
          Booking_lbl_Booking_history,
          Booking_ic_history,
          () {
            BookingHistory().launch(context);
          },
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
            width: 90.0,
            height: 90.0,
            child: commonCacheImageWidget(
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
                0),
          ).cornerRadiusWithClipRRect(50),
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
}
