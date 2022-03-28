import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:bookingapp/services/home.page.service.dart';
import 'package:flutter/material.dart';

import '../components/HotelListComponent.dart';
import '../services/hotel.page.service.dart';

class BookingHotelFragment extends StatelessWidget {
  const BookingHotelFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<BookingHotelModel>> hotelList = getHotelData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel'),
      ),
      body: SingleChildScrollView(
        child: Column(
        
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // DropdownButton(items: items, onChanged: (String? newValue) { }),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(40, 40),
                    backgroundColor: kPrimaryColor,
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.filter_list,
                    size: 30,
                    color: kTextLightColor,
                  ),
                ),
              ],
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
                            ? HolelListComponent(
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
