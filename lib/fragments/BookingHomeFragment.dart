import 'package:bookingapp/components/BookingLoadingComponent.dart';
import 'package:bookingapp/components/BookingTypeFilterComponent.dart';
import 'package:bookingapp/components/CarListComponent.dart';
import 'package:bookingapp/components/DestinationListComponent.dart';
import 'package:bookingapp/components/HotelListComponent.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:bookingapp/services/home.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class BookingHomeFragment extends StatelessWidget {
  final StringCallBack? callBack;
  final String? localeCheck;
  const BookingHomeFragment({Key? key, this.callBack, this.localeCheck})
      : super(key: key);

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
                    return BookingLoadingComponent(
                      height: context.height(),
                      width: context.width(),
                    );
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
                                localeCheck != null && localeCheck == "MM"
                                    ? titleWrapper(
                                        title: "???????????????????????????",
                                        subtitle: "???????????????????????????????????????",
                                      )
                                    : titleWrapper(
                                        title: data.title,
                                        subtitle: data.subtitle,
                                      ),
                                20.height,
                                BookingTypeComponent(
                                  callBack: (val) {
                                    callBack!(val.toString());
                                  },
                                ),
                                20.height,
                                localeCheck != null && localeCheck == "MM"
                                    ? titleWrapper(
                                        title: "??????????????????????????????????????????????????????",
                                        subtitle:
                                            "???????????????????????????????????????????????????????????? ??????????????????????????????????????? ????????????????????????????????????????????????????????????????????????",
                                      )
                                    : titleWrapper(
                                        title: data.htitle,
                                        subtitle: data.hsubtitle),
                                20.height,
                                HotelListComponent(
                                  isHome: true,
                                  hotellist: data.hotellist,
                                ),
                                20.height,
                                localeCheck != null && localeCheck == "MM"
                                    ? titleWrapper(
                                        title: "????????????????????????????????????????????????",
                                        subtitle:
                                            "It is a long established fact that a reader",
                                      )
                                    : titleWrapper(
                                        title: data.dtitle,
                                        subtitle: data.dsubtitle),
                                20.height,
                                DestinationListComponent(
                                  destinationlist: data.distlist,
                                ),
                                20.height,
                                localeCheck != null && localeCheck == "MM"
                                    ? titleWrapper(
                                        title: "?????????????????????????????????????????????",
                                        subtitle:
                                            "???????????????????????????????????????????????? ????????????????????????????????????????????????????????? ???????????????????????????????????????????????????????????????????????? ???????????????????????????????????????",
                                      )
                                    : titleWrapper(
                                        title: data.ctitle,
                                        subtitle: data.csubtitle),
                                20.height,
                                CarListComponent(
                                  carlist: data.carlist,
                                  isHome: true,
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
