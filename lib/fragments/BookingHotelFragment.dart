import 'package:bookingapp/components/BookingLoadingComponent.dart';
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
  ScrollController _scrollController = ScrollController();
  List<BookingHotelModel> hotel_list = [];
  bool firstTime = true;
  bool noMoreData = false;
  bool loadMoreRunning = false;
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_scrollListener);
    super.initState();
    hotelList = getHotelData("page=" + page.toString());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        noMoreData == false &&
        loadMoreRunning == false) {
      page += 1;
      setState(() {
        loadMoreRunning = true;
      });
      List<BookingHotelModel> newData =
          await getHotelData("page=" + page.toString());

      setState(() {
        // fetchPost(gcm);
        firstTime = false;
        loadMoreRunning = false;
        newData.isNotEmpty ? hotel_list.addAll(newData) : noMoreData = true;
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
        title: const Text('Hotel'),
        automaticallyImplyLeading: false,
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
                    type: 'Hotel',
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
                      return BookingLoadingComponent(
                        height: context.height(),
                        width: context.width(),
                      );
                    default:
                      if (snapshot.hasError)
                        // ignore: curly_braces_in_flow_control_structures
                        return Text('Error: ${snapshot.error}');
                      else {
                        List<BookingHotelModel>? data = snapshot.data;
                        data != null && firstTime
                            ? hotel_list.addAll(data)
                            : "";
                        // selectedOne = null;
                        return data != null
                            ? HotelListComponent(
                                hotellist: hotel_list,
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
