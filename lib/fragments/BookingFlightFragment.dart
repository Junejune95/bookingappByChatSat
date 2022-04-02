import 'package:bookingapp/components/FilterButtonComponent.dart';
import 'package:bookingapp/components/FlightListComponent.dart';
import 'package:bookingapp/components/SortByComponent.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/services/flight.page.service.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingFightFragment extends StatefulWidget {
  const BookingFightFragment({Key? key}) : super(key: key);

  @override
  State<BookingFightFragment> createState() => _BookingFightFragmentState();
}

class _BookingFightFragmentState extends State<BookingFightFragment> {
  late Future<List<FlightModel>> flightList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flightList = getFlightData("");
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
                        flightList = getFlightData(val);
                      });
                    },
                  )
                ],
              ),
            ),
            FutureBuilder<List<FlightModel>>(
                future: flightList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    // return SpinKitFadingFour(color: Colors.green);
                    default:
                      if (snapshot.hasError)
                        // ignore: curly_braces_in_flow_control_structures
                        return Text('Error: ${snapshot.error}');
                      else {
                        List<FlightModel>? data = snapshot.data;

                        // selectedOne = null;
                        return data != null
                            ? FlightListComponent(
                                flightlist: data,
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
