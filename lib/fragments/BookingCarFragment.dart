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
  List<CarModel> car_list = [];
  ScrollController _scrollController = ScrollController();
  bool firstTime = true;
  bool noMoreData = false;
  bool loadMoreRunning = false;
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_scrollListener);
    super.initState();
    carList = getCarData("");
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() async {
    print(_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        noMoreData == false &&
        loadMoreRunning == false);
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        noMoreData == false &&
        loadMoreRunning == false) {
      page += 1;
      setState(() {
        loadMoreRunning = true;
      });
      List<CarModel> newData = await getCarData("page=" + page.toString());
      print(newData.length);
      setState(() {
        // fetchPost(gcm);
        firstTime = false;
        loadMoreRunning = false;
        newData.isNotEmpty ? car_list.addAll(newData) : noMoreData = true;
        if (noMoreData) {
          _scrollController.removeListener(_scrollListener);
          fetchResults();
        }
      });
    }
  }

  fetchResults() {
    Future.delayed(const Duration(seconds: 1), () {
      print("in delay");
      setState(() {
        noMoreData = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Car'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
                        carList = getCarData(val + "&page=$page");
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
                        data != null && firstTime ? car_list.addAll(data) : "";
                        // selectedOne = null;
                        return data != null
                            ? CarListComponent(
                                carlist: car_list,
                                isHome: false,
                              )
                            : Container(
                                child: const Text(" No Data Exist "),
                              );
                      }
                  }
                }),
            if (loadMoreRunning == true)
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            SizedBox(
              height: noMoreData == true && firstTime == false ? 50 : 0,
              child: const Text('You have fetched all of the content'),
            ),
          ],
        ),
      ),
    );
  }
}
