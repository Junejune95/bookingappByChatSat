import 'package:bookingapp/components/BookingTypeFilterComponent.dart';
import 'package:bookingapp/components/HotelListComponent.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:bookingapp/services/home.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingHomeFragment extends StatelessWidget {
  const BookingHomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<HomePageModel> homepage = getHomeData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: appColorPrimaryLight,
        body: SingleChildScrollView(
            child: FutureBuilder<HomePageModel>(
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
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    titleWrapper(
                                        title: data.title,
                                        subtitle: data.subtitle),
                                    20.height,
                                    BookingTypeComponent(),
                                    20.height,
                                    titleWrapper(
                                        title: data.hotellist[0].title,
                                        subtitle: data.hotellist[0].subtitle),
                                    20.height,
                                    HolelListComponent(
                                      isHome: true,
                                      hotellist: data.hotellist,
                                    )
                                  ])
                            : Container(
                                child: const Text(" No Data Exist "),
                              );
                      }
                  }
                })),
      ),
    );
  }
}

Widget titleWrapper({required String title, required String subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      titleText(title: title),
      8.height,
      descriptionText(description: subtitle)
    ],
  ).paddingSymmetric(horizontal: 16);
}
