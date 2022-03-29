import 'package:bookingapp/models/DestinationModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DestinationListComponent extends StatelessWidget {
  DestinationListComponent({Key? key, required this.destinationlist})
      : super(key: key);

  final List<DestinationModel> destinationlist;

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: destinationlist.length,
      itemBuilder: (context, index) {
        return Container(
          width: 320.0,
          height: 180.0,
          decoration: BoxDecoration(
            borderRadius: radius(8),
            image: DecorationImage(
              image: NetworkImage(destinationlist[index].image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.hardLight,
              ),
            ),
          ),
          child: Center(
            child: titleText(
              title: destinationlist[index].title,
              color: Booking_TextColorWhite,
            ),
          ),
        );
      },
    );
  }
}
