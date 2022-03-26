import 'package:bookingapp/components/BookingTypeFilterComponent.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHomeFragment extends StatelessWidget {
  const BookingHomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColorPrimaryLight,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWrapper(
                  title: 'Hi There!', subtitle: 'Where would you like to go?'),
              20.height,
              BookingTypeComponent(),
              20.height,
              titleWrapper(
                  title: 'Bestseller Listing',
                  subtitle: 'Hotel highly rated for thoughtful design'),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleWrapper({required String title, required String subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleText(title: title),
      8.height,
      descriptionText(description: subtitle)
      //     .paddingSymmetric(horizontal: 16),
    ],
  ).paddingSymmetric(horizontal: 16);
}
