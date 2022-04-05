import 'package:bookingapp/screen/BookingCarFilterScreen.dart';
import 'package:bookingapp/screen/BookingFlightFilterScreen.dart';
import 'package:bookingapp/screen/BookingHotelFilterScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class FilterButtonComponent extends StatelessWidget {
  const FilterButtonComponent({Key? key, this.callBack, required this.type})
      : super(key: key);
  final StringCallBack? callBack;
  final String type;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(40, 40),
        backgroundColor: Booking_Secondary,
        elevation: 2,
      ),
      onPressed: () {
        if (type == 'Hotel') {
          HotelFilterScreen(
            callBack: (val) {
              callBack!(val);
            },
          ).launch(context,
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
        } else if (type == 'Car') {
          BookingCarFilterScreen(
            callBack: (val) {
              callBack!(val);
            },
          ).launch(context,
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
        } else if (type == 'Flight') {
          BookingFlightFilterScreen(
            callBack: (val) {
              callBack!(val);
            },
          ).launch(context,
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
        }
      },
      child: const Icon(
        Icons.filter_list,
        size: 30,
        color: Booking_TextColorWhite,
      ),
    );
  }
}
