import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/BookingWidgets.dart';

class CarListComponent extends StatelessWidget {
  const CarListComponent(
      {Key? key, required this.carlist, required this.isHome})
      : super(key: key);

  final List<CarModel> carlist;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return isHome == true
        ? carListHome()
        : ListView.builder(
            itemCount: carlist.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return defaultCard(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        height: 200,
                        width: SizeConfig.screenWidth,
                        padding: EdgeInsets.all(20),
                        child: commonCacheImageWidget(carlist[index].image, 0),
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: NetworkImage(carlist[index].image),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      ).cornerRadiusWithClipRRectOnly(
                          topLeft: 10, topRight: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              titleText(
                                  title: carlist[index].title,
                                  size: 16,
                                  width: context.width() / 4),
                              priceWrapper(
                                price: carlist[index].price,
                                unit: 'night',
                                isFullScreen: true,
                              ),
                            ],
                          ),
                          18.height,
                          locationWrapper(location: carlist[index].location),
                          20.height,
                          Row(
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
  }

  HorizontalList carListHome() {
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
                    child: titleText(title: carlist[index].title, size: 16),
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
                        12.width,
                        priceWrapper(
                            price: carlist[index].price,
                            unit: 'day',
                            isFullScreen: false,
                            alignment: MainAxisAlignment.start),
                      ],
                    ),
                  ),
                  16.height,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Booking_AppBar,
                      borderRadius: radiusOnly(bottomLeft: 8, bottomRight: 8),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Widget carServiceWidget(String service, IconData ic) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            width: isHome == true ? 30 : 42,
            height: isHome == true ? 30 : 42,
            decoration: BoxDecoration(
              color: Booking_AppBar,
              borderRadius: radius(8),
              border: Border.all(
                color: Booking_Primary,
                style: isHome == true ? BorderStyle.none : BorderStyle.solid,
                width: 0.4,
              ),
            ),
            child: Icon(
              ic,
              color: Booking_Primary,
            ),
          ),
          8.height,
          Text(
            service,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
