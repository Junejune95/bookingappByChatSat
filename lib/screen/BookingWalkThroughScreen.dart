import 'package:bookingapp/main.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingWalkThrough extends StatefulWidget {
  @override
  _BookingWalkThroughState createState() => _BookingWalkThroughState();
}

class _BookingWalkThroughState extends State<BookingWalkThrough> {
  int currentIndexPage = 0;
  int? pageLength;

  var titles = [
    Booking_lbl_Walk1Title,
    Booking_lbl_Walk2Title,
    Booking_lbl_Walk3Title
  ];

  var subTitles = [
    Bookking_lbl_Walk1SubTitle,
    Bookking_lbl_Walk1SubTitle,
    Bookking_lbl_Walk1SubTitle
  ];

  @override
  void initState() {
    // setStatusBarColor(appStore.isDarkModeOn ? black : white);
    currentIndexPage = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(Booking_Secondary);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: PageView(
              children: [
                WalkThrough(textContent: Booking_ic_walk1),
                WalkThrough(textContent: Booking_ic_walk1),
                WalkThrough(textContent: Booking_ic_walk1),
              ],
              onPageChanged: (value) {
                setState(() {
                  currentIndexPage = value;
                });
              },
            ),
          ),
          Positioned(
            width: context.width(),
            bottom: context.height() * 0.38,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(titles[currentIndexPage],
                      style: boldTextStyle(size: 20)),
                  10.height,
                  // Adding Button
                ],
              ),
            ),
          ),
          Positioned(
            width: context.width(),
            height: 50,
            top: context.height() * 0.58,
            child: Align(
              alignment: Alignment.center,
              child: DotsIndicator(
                dotsCount: 3,
                position: currentIndexPage.toDouble(),
                decorator: DotsDecorator(
                    color: Booking_greyColor, activeColor: Booking_Primary),
              ),
            ),
          ),
          Positioned(
            width: context.width(),
            top: context.height() * 0.6,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      subTitles[currentIndexPage],
                      style: primaryTextStyle(
                          fontFamily: fontRegular,
                          size: 14,
                          color: Booking_TextColorSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  50.height,
                  // Adding Button
                  defaultButton(
                    text: Booking_lbl_getStart,
                    tap: () {
                      // finish(context);
                      Checkscreen(
                        checktoken: false,
                      ).launch(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;

  WalkThrough({Key? key, required this.textContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Container(
            width: context.width(),
            height: 350,
            alignment: Alignment.center,
            child: Image.asset(textContent, width: 300, height: 300),
          ),
        ),
      ],
    );
  }
}
