import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:bookingapp/services/home.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HolelListComponent extends StatelessWidget {
  HolelListComponent({required this.isHome, Key? key}) : super(key: key);

  final bool isHome;

  List<BookingHotelModel> hotelList = getHotelList();

  @override
  Widget build(BuildContext context) {
    Future<HomePageModel> homepage = getHomeData();
    return FutureBuilder<HomePageModel>(
        future: homepage,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            // return SpinKitFadingFour(color: Colors.green);
            default:
              if (snapshot.hasError)
                // ignore: curly_braces_in_flow_control_structures
                return Text('Error: ${snapshot.error}');
              else {
                HomePageModel? data = snapshot.data;

                // selectedOne = null;
                return data != null
                    ? HorizontalList(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        spacing: 16,
                        itemCount: data.hotellist.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: radius(16),
                              boxShadow: defaultBoxShadow(
                                shadowColor: Colors.black.withOpacity(0.1),
                                blurRadius: 4.0,
                                spreadRadius: 0.3,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.network(
                                    data.hotellist[index].image,
                                    height: 140,
                                    fit: BoxFit.cover,
                                  ).cornerRadiusWithClipRRect(10),
                                ),
                                titleText(
                                  title: data.hotellist[index].name,
                                  size: 16,
                                ),
                                8.height,
                                locationWrapper(
                                    location: data.hotellist[index].location),
                                8.height,
                                priceWrapper(price: data.hotellist[index].price)
                              ],
                            ),
                          );
                        },
                      )
                    : Container(
                        child: const Text(" No Data Exist "),
                      );
              }
          }
        });
  }
}
