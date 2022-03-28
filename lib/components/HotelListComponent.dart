import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HolelListComponent extends StatelessWidget {
  HolelListComponent({required this.isHome, Key? key, required this.hotellist})
      : super(key: key);

  final bool isHome;
  final List<BookingHotelModel> hotellist;

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: hotellist.length,
      itemBuilder: (context, index) {
        return Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius(16),
            boxShadow: defaultBoxShadow(
              shadowColor: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              spreadRadius: 0.3,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.network(
                  hotellist[index].image,
                  height: 140,
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(10),
              ),
              titleText(
                title: hotellist[index].name,
                size: 16,
              ),
              8.height,
              locationWrapper(location: hotellist[index].location),
              8.height,
              priceWrapper(price: hotellist[index].price)
            ],
          ),
        );
      },
    );
  }
}
