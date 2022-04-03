// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:flutter/material.dart';

class CounterComponent extends StatefulWidget {
  CounterComponent({Key? key}) : super(key: key);

  @override
  State<CounterComponent> createState() => _CounterComponentState();
}

class _CounterComponentState extends State<CounterComponent> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _itemCount != 0
            ? circleWidget(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  color: Booking_TextColorWhite,
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() => _itemCount--),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _itemCount.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        circleWidget(
            child: IconButton(
                padding: EdgeInsets.all(0),
                color: Booking_TextColorWhite,
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () => setState(() => _itemCount++)))
      ],
    );
  }

  Container circleWidget({required Widget child}) {
    return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Booking_Secondary,
        ),
        child: child);
  }
}
