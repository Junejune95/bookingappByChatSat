import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/screen/BookingCarBookNowScreen.dart';
import 'package:bookingapp/services/car.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDetailCommon.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

late Future<CarModel?> carmodel;

class BookingCarDetailScreen extends StatelessWidget {
  final int id;
  BookingCarDetailScreen({Key? key, required this.id}) : super(key: key);

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
    carmodel = getCarDetail(id.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: FutureBuilder<CarModel?>(
          future: carmodel,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              // return SpinKitFadingFour(color: Colors.green);
              default:
                if (snapshot.hasError)
                  // ignore: curly_braces_in_flow_control_structures
                  return Text('Error: ${snapshot.error}');
                else {
                  CarModel? data = snapshot.data;
                  return data != null
                      ? bottomBookNowWidget(context, () {
                          BookingCarBookNowScreen(
                            id: data.id,
                            bookingfee: data.bookingfee ?? [],
                            extrafee: data.extrafee ?? [],
                          ).launch(context,
                              pageRouteAnimation:
                                  PageRouteAnimation.SlideBottomTop);
                        }, data.price, '/ day')
                      : Container(
                          child: const Text(" No Data Exist "),
                        );
                }
            }
          }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<CarModel?>(
              future: carmodel,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  // return SpinKitFadingFour(color: Colors.green);
                  default:
                    if (snapshot.hasError)
                      // ignore: curly_braces_in_flow_control_structures
                      return Text('Error: ${snapshot.error}');
                    else {
                      CarModel? data = snapshot.data;
                      return data != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                upperImageViewWidget(context, data.image, '',
                                    data.gallery ?? []),
                                12.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: titleText(title: data.title),
                                ),
                                20.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: locationWrapper(
                                      location: data.location,
                                      color: Booking_TextColorPrimary,
                                      size: 16,
                                      iconSize: 20),
                                ),
                                24.height,
                                galleryWidget(data.gallery),
                                reviewBoxWidget(context, data.reviewer,
                                    data.reviewstatus, data.rating),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      labelText(
                                          title: Booking_lbl_Car_features,
                                          color: Booking_TextColorPrimary),
                                      10.height,
                                      SizedBox(
                                        child: ListView.builder(
                                            // physics:
                                            //     const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.featurelist?.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, i) {
                                              return carFeatureIconWidget(
                                                  data.featurelist![i]);
                                            }),
                                        height: 60,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     carFeatureIconWidget(
                                      //         Booking_ic_airbag),
                                      //     carFeatureIconWidget(
                                      //         Booking_ic_radio),
                                      //     carFeatureIconWidget(Booking_ic_door),
                                      //     carFeatureIconWidget(
                                      //         Booking_ic_speed),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                                descriptionWrapper(data.content),
                                16.height,
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

  Container carFeatureIconWidget(ic) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radius(10), backgroundColor: Booking_AppBar),
      child: Icon(
        ic == "Airbag"
            ? Booking_ic_airbag
            : ic == "FM Radio"
                ? Booking_ic_radio
                : ic == "Power Windows"
                    ? Booking_ic_door
                    : ic == "Sensor"
                        ? Booking_ic_sensor
                        : ic == "Speed Km"
                            ? Booking_ic_speed
                            : Booking_ic_speed,
        color: Booking_TextColorPrimary,
        size: 26,
      ),
    );
  }
}
