import 'package:bookingapp/constants.dart';
import 'package:flutter/material.dart';

class BookingHotelFragment extends StatelessWidget {
  const BookingHotelFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // DropdownButton(items: items, onChanged: (String? newValue) { }),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(40, 40),
              backgroundColor: kPrimaryColor,
              elevation: 2,
            ),
            onPressed: () {},
            child: const Icon(
              Icons.filter_list,
              size: 30,
              color: kTextLightColor,
            ),
          ),
        ],
      ),
    );
  }
}
