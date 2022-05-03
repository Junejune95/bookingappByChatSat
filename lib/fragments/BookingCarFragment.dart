import 'package:bookingapp/components/BookingLoadingComponent.dart';
import 'package:bookingapp/components/CarListComponent.dart';
import 'package:bookingapp/components/FilterButtonComponent.dart';
import 'package:bookingapp/components/SortByComponent.dart';
import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/services/car.page.service.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingCarFragment extends StatefulWidget {
  const BookingCarFragment({Key? key}) : super(key: key);

  @override
  State<BookingCarFragment> createState() => _BookingCarFragmentState();
}

class _BookingCarFragmentState extends State<BookingCarFragment> {
  late Future<List<CarModel>> carList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carList = getCarData("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Car'),
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
                        carList = getCarData(val);
                      });
                    },
                    type: 'Car',
                  )
                ],
              ),
            ),
            FutureBuilder<List<CarModel>>(
                future: carList,
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
                        List<CarModel>? data = snapshot.data;

                        // selectedOne = null;
                        return data != null
                            ? CarListComponent(
                                carlist: data,
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
