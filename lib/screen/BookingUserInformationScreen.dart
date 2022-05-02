// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/BookingUserLocationComponent.dart';
import 'package:bookingapp/components/UserInfoComponent.dart';
import 'package:bookingapp/models/UserModel.dart';
import 'package:bookingapp/services/user.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

Future<UserModel>? userModel;

class BookingUserInformationScreen extends StatelessWidget {
  const BookingUserInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userModel = getCurrentUser();
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    snap: false,
                    expandedHeight: 160.0,

                    flexibleSpace: FlexibleSpaceBar(
                      // title: Text('Goa', textScaleFactor: 1),
                      background: FutureBuilder<UserModel?>(
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
                                      ? upperContainer(data)
                                      : Container(
                                          child: const Text(" No Data Exist "),
                                        );
                                }
                            }
                          }),
                      stretchModes: [StretchMode.zoomBackground],
                    ),
                    //collapsedHeight: 100,
                  ),
                  SliverPersistentHeader(
                    delegate: MyCustomAppBar(
                      color: Booking_greyColor,
                      tabBar: TabBar(
                        labelColor: Booking_TextColorPrimary,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),

                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          Tab(
                            text: Booking_lbl_information.toUpperCase(),
                          ),
                          Tab(
                            text: Booking_lbl_Location.toUpperCase(),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    // floating: false,
                  ),
                ];
              },
              body: FutureBuilder<UserModel?>(
                  future: userModel,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError)
                          // ignore: curly_braces_in_flow_control_structures
                          return Text('Error: ${snapshot.error}');
                        else {
                          UserModel? data = snapshot.data;
                          return data != null
                              ? TabBarView(
                                  children: [
                                    UserInformation(
                                      userModel: data,
                                    ),
                                    BookinUserLocationComponent(
                                      userModel: data,
                                    )
                                  ],
                                )
                              : Container(
                                  child: const Text(" No Data Exist "),
                                );
                        }
                    }
                  })),
        ),
      ),
    );
  }

  Container upperContainer(UserModel user) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
      color: Booking_Primary_light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.width,
          Container(
            width: 100.0,
            height: 100.0,
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
              10.height,
              Text(
                user.name,
                style: TextStyle(
                  color: Booking_TextColorPrimary,
                  fontSize: textSizeLargeMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.height,
              Text(
                "Member Since " +
                    DateFormat("MMMM y")
                        .format(DateTime.parse(user.created_at)),
                style: TextStyle(
                  color: Booking_TextColorSecondary,
                  fontSize: textSizeSMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
              12.height,
              // statusBoxWidget('Become a vendor', Booking_orangeColor),
            ],
          )
        ],
      ),
    );
  }
}

class MyCustomAppBar extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color? color;

  MyCustomAppBar({required this.tabBar, this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: tabBar,
      color: color,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
