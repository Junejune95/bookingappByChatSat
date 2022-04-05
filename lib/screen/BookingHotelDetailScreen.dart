// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:readmore/readmore.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              upperImageViewWidget(context),
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
              galleryWidget(),
              reviewBoxWidget(context),
              FilterTagListComponent(
                typeList: facilitiesList,
                label: 'Facilities',
                isIcon: true,
                callback: (val) {},
                labelColor: Booking_Primary,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: labelText(
                    title: Booking_lbl_Description,
                    color: Booking_TextColorPrimary),
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: ReadMoreText(
                  'Built in 1986, Hotel Stanford is a distinct addition to New York (NY) and a smart choice for travelers. The excitement of the city center is only 0 KM away. No less exceptional is the hotel’s easy access to the city’s myriad attractions and landmarks, such as',
                  trimLines: 2,
                  colorClickableText: Booking_TextColorSecondary,
                  trimMode: TrimMode.Line,
                  style: TextStyle(
                    color: Booking_TextColorSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  trimCollapsedText: 'Show more',
                  // trimExpandedText: 'Show less',
                  lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container reviewBoxWidget(BuildContext context) {
    return Container(
      width: context.width(),
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Booking_Primary_light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingComponent(
            isIndicator: true,
            rating: 4.5,
            iconSize: 26,
          ),
          14.height,
          Row(
            children: [
              Text('5.0 (10) / Excellent'),
              10.width,
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    color: Booking_TextColorSecondary, shape: BoxShape.circle),
              ),
              10.width,
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      '2 Reviews',
                      style: TextStyle(
                        color: Booking_Secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Booking_ic_forward,
                      size: 16,
                      color: Booking_Secondary,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column galleryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: labelText(
              title: Booking_lbl_Gallery, color: Booking_TextColorPrimary),
        ),
        10.height,
        HorizontalList(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: commonCacheImageWidget(urls[index], 100, width: 100)
                    .cornerRadiusWithClipRRect(14),
              );
            })
      ],
    );
  }

  Stack upperImageViewWidget(BuildContext context) {
    return Stack(
      children: [
        imageViewWidget(context),
        Positioned(
          left: 20,
          top: 20,
          child: imageactionWidget(
              ic: Booking_ic_back, onTap: () => {Navigator.of(context).pop()}),
        ),
        Positioned(
          right: 118,
          top: 20,
          child: imageactionWidget(ic: Booking_ic_zoomout, onTap: () => {}),
        ),
        Positioned(
          right: 68,
          top: 20,
          child: imageactionWidget(ic: Booking_ic_fav, onTap: () => {}),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: imageactionWidget(ic: Booking_ic_share, onTap: () => {}),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: videoViewBtn(),
        ),
      ],
    );
  }

  Container videoViewBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: iconColorPrimary.withOpacity(0.5),
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_Primary.withOpacity(0.2),
          blurRadius: 4.0,
          spreadRadius: 0.4,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Booking_ic_video,
            color: Booking_Primary_light,
            size: 30,
          ),
          8.width,
          const Text(
            'Hotel Video',
            style: TextStyle(
                fontSize: 18,
                color: Booking_TextColorWhite,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Container imageViewWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: commonCacheImageWidget(
              'https://media.istockphoto.com/photos/luxury-resort-picture-id104731717?k=20&m=104731717&s=612x612&w=0&h=40INtJRzhmU1O4Rj24zdY8vj4aGsWpPaEfojaVQ8xBo=',
              240,
              width: context.width())
          .cornerRadiusWithClipRRect(14),
    );
  }

  InkWell imageactionWidget(
      {required IconData ic, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: iconColorPrimary.withOpacity(0.5),
          shape: BoxShape.circle,
          boxShadow: defaultBoxShadow(
            shadowColor: Booking_Primary.withOpacity(0.2),
            blurRadius: 4.0,
            spreadRadius: 0.4,
          ),
        ),
        child: Icon(
          ic,
          color: Booking_Primary_light,
        ),
      ),
    );
  }
}
