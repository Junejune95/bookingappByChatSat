import 'package:bookingapp/components/FilterButtonComponent.dart';
import 'package:bookingapp/components/SortByComponent.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/HotelListComponent.dart';
import '../services/hotel.page.service.dart';

class BookingHotelFragment extends StatefulWidget {
  const BookingHotelFragment({Key? key}) : super(key: key);
  @override
  State<BookingHotelFragment> createState() => _BookingHotelFragmentState();
}

class _BookingHotelFragmentState extends State<BookingHotelFragment> {
  late Future<List<BookingHotelModel>> hotelList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotelList = getHotelData("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SortByComponent(),
                  10.width,
                  FilterButtonComponent(
                    callBack: (val) {
                      setState(() {
                        hotelList = getHotelData(val);
                      });
                    },
                  )
                ],
              ),
            ),
            FutureBuilder<List<BookingHotelModel>>(
                future: hotelList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    // return SpinKitFadingFour(color: Colors.green);
                    default:
                      if (snapshot.hasError)
                        // ignore: curly_braces_in_flow_control_structures
                        return Text('Error: ${snapshot.error}');
                      else {
                        List<BookingHotelModel>? data = snapshot.data;

                        // selectedOne = null;
                        return data != null
                            ? HotelListComponent(
                                hotellist: data,
                                isHome: false,
                              )
                            : Container(
                                child: const Text(" No Data Exist "),
                              );
                      }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
