import 'package:bookingapp/screen/HotelFilterScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterButtonComponent extends StatelessWidget {
  const FilterButtonComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(40, 40),
        backgroundColor: Booking_Secondary,
        elevation: 2,
      ),
      onPressed: () {
        HotelFilterScreen().launch(context, pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
      },
      child: const Icon(
        Icons.filter_list,
        size: 30,
        color: Booking_TextColorWhite,
      ),
    );
  }
}
