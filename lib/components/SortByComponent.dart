import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:flutter/material.dart';

class SortByComponent extends StatefulWidget {
  SortByComponent({Key? key}) : super(key: key);

  @override
  State<SortByComponent> createState() => _SortByComponentState();
}

class _SortByComponentState extends State<SortByComponent> {
  // Initial Selected Value
  String dropdownvalue = Booking_lbl_Booking_SortBy1;

  List<String> items = [
    Booking_lbl_Booking_SortBy1,
    Booking_lbl_Booking_SortBy2,
    Booking_lbl_Booking_SortBy3,
    Booking_lbl_Booking_SortBy4,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Booking_LineColor,
          style: BorderStyle.solid,
          width: 0.80,
        ),
      ),
      child: DropdownButton(
        underline: SizedBox(),
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        },
      ),
    );
  }
}
