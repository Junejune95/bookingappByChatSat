import 'package:bookingapp/components/FilterTagListComponent.dart';
import 'package:bookingapp/components/PriceRangeComponent.dart';
import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingDataGenerator.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';

class HotelFilterScreen extends StatefulWidget {
  HotelFilterScreen({Key? key}) : super(key: key);

  @override
  State<HotelFilterScreen> createState() => _HotelFilterScreenState();
}

class _HotelFilterScreenState extends State<HotelFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        child: defaultButton(
          text: Booking_lbl_btn_Apply,
          tap: () {},
          height: 40
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: PriceRangeComponent(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RatingComponent(
                isIndicator: false,
                label: 'Hotel Star',
              ),
            ),
            20.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RatingComponent(
                isIndicator: false,
                label: 'Review Score',
              ),
            ),
            20.height,
            FilterTagListComponent(
              typeList: propertyTypeList,
              label: 'Property type',
              isIcon: false,
            ),
            20.height,
            FilterTagListComponent(
              typeList: facilitiesList,
              label: 'Facilities',
              isIcon: true,
            ),
            20.height,
            FilterTagListComponent(
              typeList: hotelServiceList,
              label: 'Hotel Service',
              isIcon: false,
            )
          ],
        ),
      ),
    );
  }
}
