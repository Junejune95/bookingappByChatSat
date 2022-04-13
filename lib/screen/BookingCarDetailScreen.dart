import 'package:bookingapp/screen/BookingCarBookNowScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
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
      bottomNavigationBar: bottomBookNowWidget(context, () {
        const BookingCarBookNowScreen().launch(context,
            pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
      }, 0.0, ''),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upperImageViewWidget(context, '', '', urls),
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
              reviewBoxWidget(context, 2, 'Excellent', 5.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                        title: Booking_lbl_Car_features,
                        color: Booking_TextColorPrimary),
                    10.height,
                    Row(
                      children: [
                        carFeatureIconWidget(Booking_ic_airbag),
                        carFeatureIconWidget(Booking_ic_radio),
                        carFeatureIconWidget(Booking_ic_door),
                        carFeatureIconWidget(Booking_ic_speed),
                      ],
                    )
                  ],
                ),
              ),
              16.height,
              descriptionWrapper(
                  'Built in 1986, Hotel Stanford is a distinct addition to New York (NY) and a smart choice for travelers. The excitement of the city center is only 0 KM away. No less exceptional is the hotel’s easy access to the city’s myriad attractions and landmarks, such as'),
              16.height,
            ],
          ),
        ),
      ),
    );
  }

  Container carFeatureIconWidget(ic) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(10), backgroundColor: Booking_AppBar),
      child: Icon(
        ic,
        color: Booking_TextColorPrimary,
        size: 26,
      ),
    );
  }
}
