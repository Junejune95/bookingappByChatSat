import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/screen/BookingImagePreviewScreen.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Stack upperImageViewWidget(BuildContext context, List<String> urls) {
  return Stack(
    children: [
      imageViewWidget(context, urls[0]),
      Positioned(
        left: 20,
        top: 20,
        child: imageactionWidget(
            ic: Booking_ic_back, onTap: () => {Navigator.of(context).pop()}),
      ),
      Positioned(
        right: 118,
        top: 20,
        child: imageactionWidget(
            ic: Booking_ic_zoomout,
            onTap: () => {
                  BookingImagePreviewScreen(
                    images: urls,
                  ).launch(context,
                      pageRouteAnimation: PageRouteAnimation.SlideBottomTop)
                }),
      ),
      Positioned(
        right: 68,
        top: 20,
        child: imageactionWidget(ic: Booking_ic_fav, onTap: () => {}),
      ),
      Positioned(
        right: 20,
        top: 20,
        child: imageactionWidget(ic: Booking_ic_share, onTap: () => {}),
      ),
      Positioned(
        right: 20,
        bottom: 20,
        child: videoViewBtn(),
      ),
    ],
  );
}

Container imageViewWidget(BuildContext context, url) {
  return Container(
    padding: EdgeInsets.all(10),
    child: commonCacheImageWidget(url, 240, width: context.width())
        .cornerRadiusWithClipRRect(14),
  );
}

InkWell imageactionWidget({required IconData ic, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: iconColorPrimary.withOpacity(0.5),
        shape: BoxShape.circle,
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_Primary.withOpacity(0.2),
          blurRadius: 4.0,
          spreadRadius: 0.4,
        ),
      ),
      child: Icon(
        ic,
        color: Booking_Primary_light,
      ),
    ),
  );
}

InkWell videoViewBtn() {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: iconColorPrimary.withOpacity(0.5),
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_Primary.withOpacity(0.2),
          blurRadius: 4.0,
          spreadRadius: 0.4,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Booking_ic_video,
            color: Booking_Primary_light,
            size: 30,
          ),
          8.width,
          const Text(
            'Hotel Video',
            style: TextStyle(
                fontSize: 18,
                color: Booking_TextColorWhite,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
Container reviewBoxWidget(BuildContext context) {
    return Container(
      width: context.width(),
      margin: EdgeInsets.all(14),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Booking_Primary_light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingComponent(
            isIndicator: true,
            rating: 4.5,
            iconSize: 26,
          ),
          14.height,
          Row(
            children: [
              Text('5.0 (10) / Excellent'),
              10.width,
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                    color: Booking_TextColorSecondary, shape: BoxShape.circle),
              ),
              10.width,
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      '2 Reviews',
                      style: TextStyle(
                        color: Booking_Secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Booking_ic_forward,
                      size: 16,
                      color: Booking_Secondary,
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column galleryWidget(urls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: labelText(
              title: Booking_lbl_Gallery, color: Booking_TextColorPrimary),
        ),
        10.height,
        HorizontalList(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: commonCacheImageWidget(urls[index], 100, width: 100)
                    .cornerRadiusWithClipRRect(14),
              );
            })
      ],
    );
  }