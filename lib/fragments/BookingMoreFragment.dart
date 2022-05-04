// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/models/UserModel.dart';
import 'package:bookingapp/screen/BookingHistoryScreen.dart';
import 'package:bookingapp/screen/BookingLanguageScreen.dart';
import 'package:bookingapp/screen/BookingSignInScreen.dart';
import 'package:bookingapp/screen/BookingUserInformationScreen.dart';
import 'package:bookingapp/services/user.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

Future<UserModel>? userModel;
final List locale = [
  {'name': 'English', 'locale': Locale('en', 'US')},
  {'name': 'Myanmar', 'locale': Locale('mm', 'MM')},
];

class BookingMoreFragment extends StatelessWidget {
  bool checkToken;
  String? localeCheck;
  BookingMoreFragment({Key? key, required this.checkToken, this.localeCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    userModel = getCurrentUser();
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Booking_Primary,
            child: checkToken == true
                ? FutureBuilder<UserModel?>(
                    future: userModel,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                              child: CircularProgressIndicator());
                        default:
                          if (snapshot.hasError)
                            // ignore: curly_braces_in_flow_control_structures
                            return Text('Error: ${snapshot.error}');
                          else {
                            UserModel? data = snapshot.data;
                            return data != null
                                ? data.email != ""
                                    ? afteruserloginWidget(context, data)
                                    : BookingSignInScreen()
                                : Container(
                                    child: const Text(" No Data Exist "),
                                  );
                          }
                      }
                    })
                : BookingSignInScreen()),
      ),
    );
  }

  Column afteruserloginWidget(BuildContext context, UserModel user) {
    return Column(
      children: [
        upperContainer(user),
        10.height,
        itemWidget(
          Booking_lbl_My_profile,
          Booking_ic_person,
          () {
            BookingUserInformationScreen().launch(context,
                pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
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
        // itemWidget(
        //   Booking_lbl_Change_password,
        //   Booking_ic_lock,
        //   () {},
        // ),
        // dividerWidget(),
        itemWidget(
          Booking_lbl_Language,
          Booking_ic_language,
          () {
            // BookingLanguageScreen().launch(context,
            //     pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
            showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                    title: Text('Choose Your Language'),
                    content: Container(
                      width: double.maxFinite,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Text(locale[index]['name']),
                                onTap: () async {
                                  // updateLanguage(locale[index]['locale']);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      "locale",
                                      locale[index]['name'] == "Myanmar"
                                          ? "MM"
                                          : "US");
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.blue,
                            );
                          },
                          itemCount: locale.length),
                    ),
                  );
                });
          },
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

  Container upperContainer(UserModel user) {
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
                user.name,
                style: TextStyle(
                  color: Booking_TextColorPrimary,
                  fontSize: textSizeLargeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              6.height,
              Text(
                "Member Since " +
                    DateFormat("MMMM y")
                        .format(DateTime.parse(user.created_at)),
                style: TextStyle(
                  color: Booking_TextColorSecondary,
                  fontSize: textSizeSmall,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.height,
              // statusBoxWidget('Become a vendor', Booking_orangeColor),
            ],
          )
        ],
      ),
    );
  }
}
