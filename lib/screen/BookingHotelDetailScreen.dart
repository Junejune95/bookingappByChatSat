// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/screen/BookingHotelBookNowScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHotelDetailScreen extends StatelessWidget {
  BookingHotelDetailScreen({Key? key}) : super(key: key);
  List<String> urls = [
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-4.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-1.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-2.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-3.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-5.jpg',
    'http://booking.qxlxt1pglq-xlm41kzlk3dy.p.runcloud.link/uploads/demo/hotel/gallery/hotel-gallery-4.jpg',
  ];

  List<String> highlights = [
    'See amazing works of contemporary art, including Vincent van Gogh’s The Starry Night',
    'Check out Campbell’s Soup Cans by Warhol and The Dance (I) by Matisse',
    'Enjoy free audio guides available in English, French, German, Italian, Spanish, Portuguese',
    'See amazing works of contemporary art, including Vincent van Gogh’s The Starry Night',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomBookNowWidget(context, () {
         BookingHotelBookNowScreen(
         
          ).launch(context,
              pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
      }, '/ night'),
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
              20.height,
              FilterTagListComponent(
                typeList: facilitiesList,
                label: 'Facilities',
                isIcon: true,
                callback: (val) {},
                labelColor: Booking_Primary,
              ),
              20.height,
              descriptionWrapper(
                  'Built in 1986, Hotel Stanford is a distinct addition to New York (NY) and a smart choice for travelers. The excitement of the city center is only 0 KM away. No less exceptional is the hotel’s easy access to the city’s myriad attractions and landmarks, such as'),
              28.height,
              highlightWidget(),
              10.height,
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: labelText(
                  title: Booking_lbl_Rules,
                  color: Booking_TextColorPrimary,
                ),
              ),
              16.height,
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Booking_AppBar,
                  borderRadius: radius(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ruleTimeWidget(context, Booking_lbl_CheckIn, '12:00 AM'),
                    Container(
                      width: 1,
                      color: Booking_TextColorSecondary.withOpacity(0.3),
                    ),
                    ruleTimeWidget(context, Booking_lbl_CheckOut, '12:00 PM'),
                  ],
                ),
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      title: Booking_lbl_HotelPolicies,
                      color: Booking_TextColorPrimary,
                    ),
                    8.height,
                    expandWidget('Guarantee Policy'),
                    expandWidget('Children Policy'),
                    expandWidget('Cancellation/Amendment Policy'),
                    expandWidget('Late check-out policy'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile expandWidget(String title) {
    return ExpansionTile(
      title: Container(
        child: Text(
          title,
          style: TextStyle(
              color: Booking_TextColorSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          // textAlign: TextAlign.center,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffee species.',
            style: TextStyle(
              fontSize: 16,
              color: Booking_TextColorSecondary,
            ),
            maxLines: 3,
            softWrap: true,
            // textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Container ruleTimeWidget(BuildContext context, String label, String time) {
    return Container(
      width: context.width() / 2.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelText(title: label, size: 14),
          titleText(title: time, size: 14)
        ],
      ),
    );
  }

  Column highlightWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: labelText(
            title: Booking_lbl_Highlight,
            color: Booking_TextColorPrimary,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
          child: Column(
            children: highlights.map((str) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.55,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        str,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 16,
                            color: Booking_TextColorSecondary,
                            height: 1.55,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
