import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BookingWidgets.dart';

class CarListComponent extends StatelessWidget {
  const CarListComponent({Key? key, required this.carlist}) : super(key: key);

  final List<CarModel> carlist;

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: carlist.length,
      itemBuilder: (context, index) {
        return defaultCard(
          width: 280,
          margin: EdgeInsets.symmetric(vertical: 10),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.network(
                        carlist[index].image,
                        fit: BoxFit.cover,
                      ).cornerRadiusWithClipRRect(8),
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: titleText(
                      title: carlist[index].title,
                      size: 16,
                    ),
                  ),
                  12.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: locationWrapper(location: carlist[index].location),
                  ),
                  12.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.price_change,
                          color: Booking_TextColorSecondary,
                        ),
                        10.width,
                        priceWrapper(
                            price: carlist[index].price,
                            unit: 'day',
                            isFullScreen: false,
                            alignment: MainAxisAlignment.start),
                      ],
                    ),
                  ),
                  12.height,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Booking_AppBar,
                      borderRadius: radiusOnly(bottomLeft: 8, bottomRight: 8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        carServiceWidget(
                          carlist[index].passenger.toString(),
                          Booking_ic_people,
                        ),
                        carServiceWidget(
                          carlist[index].gear,
                          Booking_ic_auto,
                        ),
                        carServiceWidget(
                          carlist[index].baggage.toString(),
                          Booking_ic_baggage,
                        ),
                        carServiceWidget(
                          carlist[index].door.toString(),
                          Booking_ic_door,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 15,
                  right: 15,
                  child: const Icon(
                    Icons.favorite_outline,
                    color: Booking_TextColorPrimary,
                    size: 24,
                  ).onTap(() {})),
            ],
          ),
        );
      },
    );
  }

  Column carServiceWidget(String service, IconData ic) {
    return Column(
      children: [
        Icon(ic),
        8.height,
        Text(
          service,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
