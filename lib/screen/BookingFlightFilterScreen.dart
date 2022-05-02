import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/components/PriceRangeComponent.dart';
import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/models/CarFilterModel.dart';
import 'package:bookingapp/models/FlightFliterModel.dart';
import 'package:bookingapp/services/flight.page.service.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class BookingFlightFilterScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BookingFlightFilterScreen({Key? key, this.callBack}) : super(key: key);
  final StringCallBack? callBack;
  @override
  State<BookingFlightFilterScreen> createState() =>
      _BookingFlightFilterScreenState();
}

class _BookingFlightFilterScreenState extends State<BookingFlightFilterScreen> {
  late Future<FligthFilterModel> flightFilterModel;
  String params = "";
  String starrate = '', reviewscore = '', pricerange = '';
  List<String> terms = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightFilterModel = getFlightFilter();
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
              Navigator.of(context).pop();
            },
            height: 40),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<FligthFilterModel>(
            future: flightFilterModel,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    // ignore: curly_braces_in_flow_control_structures
                    return Text('Error: ${snapshot.error}');
                  else {
                    FligthFilterModel? data = snapshot.data;

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
                                typeList: data.flighttypelist,
                                label: 'Flight type',
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
                                typeList: data.inflightexplist,
                                label: 'In Flight Experience',
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
