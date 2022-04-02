import 'package:bookingapp/components/FilterButtonComponent.dart';
import 'package:bookingapp/components/SortByComponent.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingFightFragment extends StatefulWidget {
  const BookingFightFragment({Key? key}) : super(key: key);

  @override
  State<BookingFightFragment> createState() => _BookingFightFragmentState();
}

class _BookingFightFragmentState extends State<BookingFightFragment> {
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
        title: const Text('Fight'),
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
          ],
        ),
      ),
    );
  }
}
