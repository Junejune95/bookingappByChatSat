import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingCarDetailScreen extends StatelessWidget {
  BookingCarDetailScreen({Key? key}) : super(key: key);

  List<String> urls = [
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-2.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-4.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-1.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-3.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-5.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/car/gallery-6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomBookNowWidget(context, () {}, ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upperImageViewWidget(context, urls),
              12.height,
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: titleText(title: 'Dylan Hotel'),
              ),
              20.height,
               Padding(
                padding: const EdgeInsets.only(left: 16),
                child: locationWrapper(
                    location: 'New York, United States',
                    color: Booking_TextColorPrimary,
                    size: 16,
                    iconSize: 20),
              ),
              24.height,
                         galleryWidget(urls),
              reviewBoxWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
