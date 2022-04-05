import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHotelDetailScreen extends StatelessWidget {
  const BookingHotelDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Booking_app_Background,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: commonCacheImageWidget(
                  'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-1.jpg',
                  240).cornerRadiusWithClipRRect(14)
            ),
            Container(

            )
          ],
        ),
      ),
    );
  }
}
