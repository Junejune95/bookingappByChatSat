// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:bookingapp/models/BookingIconModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class BookingTypeComponent extends StatefulWidget {
  final StringCallBack? callBack;
  const BookingTypeComponent({Key? key, this.callBack}) : super(key: key);
  @override
  State<BookingTypeComponent> createState() => _BookingTypeComponentState();
}

class _BookingTypeComponentState extends State<BookingTypeComponent> {
  List<BookingTypeModel> typeList = getBookingTypeList();

  late int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return HorizontalList(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        spacing: 16,
        itemCount: typeList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    widget.callBack!((index + 1).toString());
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? Booking_Secondary_light
                        : Booking_AppBar,
                    borderRadius: radius(10),
                  ),
                  child: Icon(
                    typeList[index].icon,
                    color: _selectedIndex == index
                        ? Booking_AppBar
                        : Booking_Secondary_light,
                  ),
                ),
              ),
              8.height,
              Text(
                typeList[index].name,
                style:
                    boldTextStyle(size: 14, color: Booking_TextColorSecondary),
              ),
            ],
          );
        });
  }
}
