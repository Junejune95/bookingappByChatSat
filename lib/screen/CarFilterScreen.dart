import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/components/PriceRangeComponent.dart';
import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/models/HotelFilterModel.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class CarFilterScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CarFilterScreen({Key? key, this.callBack}) : super(key: key);
  final StringCallBack? callBack;
  @override
  State<CarFilterScreen> createState() => _CarFilterScreenState();
}

class _CarFilterScreenState extends State<CarFilterScreen> {
  late Future<HotelFilterModel> hotelFilterModel;
  String params = "";
  String starrate = '', reviewscore = '', pricerange = '';
  List<String> terms = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotelFilterModel = getHotelFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: defaultButton(
            text: Booking_lbl_btn_Apply,
            tap: () {
              params += terms.join("&") +
                  "&" +
                  starrate +
                  reviewscore +
                  "&" +
                  pricerange;
              widget.callBack!(params);
            },
            height: 40),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<HotelFilterModel>(
            future: hotelFilterModel,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                // return SpinKitFadingFour(color: Colors.green);
                default:
                  if (snapshot.hasError)
                    // ignore: curly_braces_in_flow_control_structures
                    return Text('Error: ${snapshot.error}');
                  else {
                    HotelFilterModel? data = snapshot.data;

                    // selectedOne = null;
                    return data != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              20.height,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: PriceRangeComponent(
                                  minprice: data.minprice,
                                  maxprice: data.maxprice,
                                  callback: (val) {
                                    setState(() {
                                      pricerange = "price_range=" + val;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: RatingComponent(
                                  isIndicator: false,
                                  label: 'Hotel Star',
                                  callback: (val) {
                                    setState(() {
                                      starrate =
                                          "star_rate[]=" + val.toString() + "&";
                                    });
                                  },
                                ),
                              ),
                              20.height,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: RatingComponent(
                                  isIndicator: false,
                                  label: 'Review Score',
                                  callback: (val) {
                                    setState(() {
                                      reviewscore = "review_score[]=" +
                                          val.toString() +
                                          "&";
                                    });
                                  },
                                ),
                              ),
                              20.height,
                              FilterTagListComponent(
                                typeList: data.propertylist,
                                label: 'Property type',
                                isIcon: false,
                                callback: (val) {
                                  setState(() {
                                    // ignore: prefer_contains
                                    terms.indexOf(
                                                "terms[]=" + val.toString()) ==
                                            -1
                                        ? terms.add("terms[]=" + val.toString())
                                        : terms.removeAt(terms.indexOf(
                                            "terms[]=" + val.toString()));
                                  });
                                },
                              ),
                              20.height,
                              FilterTagListComponent(
                                typeList: data.facilitylist,
                                label: 'Facilities',
                                isIcon: true,
                                callback: (val) {
                                  setState(() {
                                    // ignore: prefer_contains
                                    terms.indexOf(
                                                "terms[]=" + val.toString()) ==
                                            -1
                                        ? terms.add("terms[]=" + val.toString())
                                        : terms.removeAt(terms.indexOf(
                                            "terms[]=" + val.toString()));
                                  });
                                },
                              ),
                              20.height,
                              FilterTagListComponent(
                                typeList: data.servicelist,
                                label: 'Hotel Service',
                                isIcon: false,
                                callback: (val) {
                                  setState(() {
                                    // ignore: prefer_contains
                                    terms.indexOf(
                                                "terms[]=" + val.toString()) ==
                                            -1
                                        ? terms.add("terms[]=" + val.toString())
                                        : terms.removeAt(terms.indexOf(
                                            "terms[]=" + val.toString()));
                                  });
                                },
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
    );
  }
}
