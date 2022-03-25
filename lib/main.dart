import 'package:bookingapp/screens/menu_pages/car/car.dart';
import 'package:bookingapp/screens/menu_pages/fight/fight.dart';
import 'package:bookingapp/screens/menu_pages/home/home.dart';
import 'package:bookingapp/screens/menu_pages/hotel/hotel.dart';
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
      title: 'Flutter Demo',
      theme: theme(),
      home: const CheckScreens(),
    );
  }
}

class CheckScreens extends StatefulWidget {
  const CheckScreens({Key? key}) : super(key: key);

  @override
  State<CheckScreens> createState() => _CheckScreensState();
}

class _CheckScreensState extends State<CheckScreens> {
  PageController _pageController = PageController();

  int _index = 0;
  List<Widget> screens = [
    const Home(),
    const Hotel(),
    const Car(),
    const Fight(),
    const Home(),
  ];

  _onPageChange(index) {
    print("hello reach");
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: screens,
        controller: _pageController,
        onPageChanged: _onPageChange,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
                icon: Icon(e.appMenuIcon),
                label: e.appLabelMenu,
              ),
            )
            .toList(),
      ),
    );
  }
}
