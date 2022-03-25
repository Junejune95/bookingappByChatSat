import 'package:bookingapp/constants.dart';
import 'package:bookingapp/screen/menu_pages/car/car.dart';
import 'package:bookingapp/screen/menu_pages/fight/fight.dart';
import 'package:bookingapp/screen/menu_pages/home/home.dart';
import 'package:bookingapp/screen/menu_pages/hotel/hotel.dart';
import 'package:bookingapp/theme.dart';
import 'package:flutter/material.dart';

import 'app_enum.dart';

void main() {
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
      theme: theme(),
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
    const Home(),
    const Hotel(),
    const Car(),
    const Fight(),
    const Home(),
  ];

  _onPageChange(index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: screen,
        controller: _pageController,
        onPageChanged: _onPageChange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kSecondaryColor,
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
