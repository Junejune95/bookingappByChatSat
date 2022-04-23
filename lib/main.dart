import 'package:bookingapp/fragments/BookingCarFragment.dart';
import 'package:bookingapp/fragments/BookingFlightFragment.dart';
import 'package:bookingapp/fragments/BookingHomeFragment.dart';
import 'package:bookingapp/fragments/BookingHotelFragment.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_enum.dart';
import 'fragments/BookingMoreFragment.dart';
import 'utils/AppTheme.dart';

bool checkToken = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var bearToken = prefs.getString('access_token');
  checkToken = bearToken != null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking App',
      theme: AppThemeData.lightTheme,
      home: const Checkscreen(),
    );
  }
}

class Checkscreen extends StatefulWidget {
  const Checkscreen({Key? key}) : super(key: key);

  @override
  State<Checkscreen> createState() => _CheckscreenState();
}

class _CheckscreenState extends State<Checkscreen> {
  PageController _pageController = PageController();

  int _index = 0;
  List<Widget> screen = [
    const BookingHomeFragment(),
    const BookingHotelFragment(),
    const BookingCarFragment(),
    const BookingFightFragment(),
    BookingMoreFragment(),
  ];

  _onPageChange(index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        padEnds: false,
        children: screen,
        controller: _pageController,
        onPageChanged: _onPageChange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Booking_Secondary,
        unselectedItemColor: Booking_Primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (i) {
          setState(() {
            _index = i;
            _pageController.jumpToPage(i);
          });
        },
        items: AppMenu.values
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(
                  e.appMenuIcon,
                ),
                label: e.appLabelMenu,
              ),
            )
            .toList(),
      ),
    );
  }
}
