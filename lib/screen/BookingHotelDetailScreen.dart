// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:readmore/readmore.dart';

late Future<BookingHotelModel> bookinghotelmodel;

class BookingHotelDetailScreen extends StatelessWidget {
  final int id;
  BookingHotelDetailScreen({Key? key, required this.id}) : super(key: key);
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
    bookinghotelmodel = getHotelDetail(id.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: FutureBuilder<BookingHotelModel>(
          future: bookinghotelmodel,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              // return SpinKitFadingFour(color: Colors.green);
              default:
                if (snapshot.hasError)
                  // ignore: curly_braces_in_flow_control_structures
                  return Text('Error: ${snapshot.error}');
                else {
                  BookingHotelModel? data = snapshot.data;
                  if (data?.facilitylist != null) {
                    print(data?.facilitylist?.length);
                  } // selectedOne = null;
                  return data != null
                      ? bottomNavigationWidget(context, data.price)
                      : Container(
                          child: const Text(" No Data Exist "),
                        );
                }
            }
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<BookingHotelModel>(
              future: bookinghotelmodel,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  // return SpinKitFadingFour(color: Colors.green);
                  default:
                    if (snapshot.hasError)
                      // ignore: curly_braces_in_flow_control_structures
                      return Text('Error: ${snapshot.error}');
                    else {
                      BookingHotelModel? data = snapshot.data;
                      if (data?.facilitylist != null) {
                        print(data?.facilitylist?.length);
                      } // selectedOne = null;
                      return data != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                upperImageViewWidget(
                                    context, data.image, data.video ?? ''),
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
                                galleryWidget(data.gallaries ?? []),
                                reviewBoxWidget(context, data.reviewer,
                                    data.reviewstatus, data.rating),
                                20.height,
                                FilterTagListComponent(
                                  typeList: data.facilitylist ?? [],
                                  label: 'Facilities',
                                  isIcon: true,
                                  callback: (val) {},
                                  labelColor: Booking_Primary,
                                ),
                                14.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: labelText(
                                      title: Booking_lbl_Description,
                                      color: Booking_TextColorPrimary),
                                ),
                                14.height,
                                descriptionWrapper(),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ruleTimeWidget(context,
                                          Booking_lbl_CheckIn, '12:00 AM'),
                                      Container(
                                        width: 1,
                                        color: Booking_TextColorSecondary
                                            .withOpacity(0.3),
                                      ),
                                      ruleTimeWidget(context,
                                          Booking_lbl_CheckOut, '12:00 PM'),
                                    ],
                                  ),
                                ),
                                10.height,
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      labelText(
                                        title: Booking_lbl_HotelPolicies,
                                        color: Booking_TextColorPrimary,
                                      ),
                                      8.height,
                                      expandWidget('Guarantee Policy'),
                                      expandWidget('Children Policy'),
                                      expandWidget(
                                          'Cancellation/Amendment Policy'),
                                      expandWidget('Late check-out policy'),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(
                              child: const Text(" No Data Exist "),
                            );
                    }
                }
              }),
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

  Container bottomNavigationWidget(BuildContext context, double price) {
    return Container(
      color: Booking_Primary_light,
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'From',
                  style: TextStyle(
                    color: Booking_Primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.height,
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      '\$' + price.toString(),
                      style: TextStyle(
                        color: Booking_Secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '/ night',
                      style: TextStyle(
                        color: Booking_TextColorSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: context.width() / 2,
                height: 50,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Booking_Secondary,
                  borderRadius: radius(8),
                  boxShadow: defaultBoxShadow(
                    shadowColor: Booking_Secondary.withOpacity(0.4),
                    blurRadius: 4.0,
                    spreadRadius: 0.3,
                  ),
                ),
                child: Text(
                  Booking_lbl_BookNow,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Booking_TextColorWhite,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
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

  Padding descriptionWrapper() {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: ReadMoreText(
        'Built in 1986, Hotel Stanford is a distinct addition to New York (NY) and a smart choice for travelers. The excitement of the city center is only 0 KM away. No less exceptional is the hotel’s easy access to the city’s myriad attractions and landmarks, such as',
        trimLines: 4,

        colorClickableText: Booking_TextColorSecondary,
        trimMode: TrimMode.Line,
        style: TextStyle(
            color: Booking_TextColorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5),
        trimCollapsedText: 'Show more',
        // trimExpandedText: 'Show less',
        lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container reviewBoxWidget(
      BuildContext context, int reviewer, String reviewstatus, double rating) {
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
            rating: rating,
            iconSize: 26,
          ),
          14.height,
          Row(
            children: [
              Text(rating.toString() + ' (5) / ' + reviewstatus),
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
                      reviewer.toString() + ' Reviews',
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

  Column galleryWidget(List<String> gallerylist) {
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
            itemCount: gallerylist.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child:
                    commonCacheImageWidget(gallerylist[index], 100, width: 100)
                        .cornerRadiusWithClipRRect(14),
              );
            })
      ],
    );
  }

  Stack upperImageViewWidget(
      BuildContext context, String imageUrl, String videoUrl) {
    return Stack(
      children: [
        imageViewWidget(context, imageUrl),
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
          child: videoViewBtn(videoUrl),
        ),
      ],
    );
  }

  Container videoViewBtn(String videoUrl) {
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

  Container imageViewWidget(BuildContext context, String imageUrl) {
    return Container(
      padding: EdgeInsets.all(10),
      child: commonCacheImageWidget(imageUrl, 240, width: context.width())
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
