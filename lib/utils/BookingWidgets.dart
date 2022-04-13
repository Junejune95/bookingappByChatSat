// ignore_for_file: prefer_if_null_operators, prefer_const_constructors

// import 'dart:ffi';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget headerText({required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      50.height,
      Text(title, style: boldTextStyle(size: 30, color: white)),
      16.height,
    ],
  );
}

Widget labelText(
    {required String title, int? size, int? maxLines, Color? color}) {
  return Text(
    title,
    style: boldTextStyle(
                decoration: TextDecoration.none,
        color: color != null ? color : Booking_TextColorSecondary,),
    maxLines: maxLines != null ? maxLines : 1,
    overflow: TextOverflow.ellipsis,

  );
}

Widget titleText(
    {required String title,
    int? size,
    int? maxLines,
    Color? color,
    double? width}) {
  return width != null
      ? SizedBox(
          width: width,
          child: Text(
            title,
            style: boldTextStyle(
                decoration: TextDecoration.none,
                size: size != null ? size : textSizeNormal.toInt(),
                color: color != null ? color : Booking_TextColorPrimary),
            maxLines: maxLines != null ? maxLines : 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      : Text(
          title,
          style: boldTextStyle(
              decoration: TextDecoration.none,
              size: size != null ? size : textSizeNormal.toInt(),
              color: color != null ? color : Booking_TextColorPrimary),
          maxLines: maxLines != null ? maxLines : 1,
          overflow: TextOverflow.ellipsis,
        );
}

Widget descriptionText(
    {required String description, int? size, int? maxLines}) {
  return Text(
    description,
    style: boldTextStyle(
        size: size != null ? size : textSizeSmall.toInt(),
        color: Booking_TextColorSecondary),
    maxLines: maxLines != null ? maxLines : 1,
    overflow: TextOverflow.ellipsis,
  );
}

Widget locationWrapper(
    {required String location,
    int? size,
    double? iconSize,
    Color? color,
    bool? isFontWeight}) {
  return Row(
    children: [
      Icon(Booking_ic_location,
          size: iconSize != null ? iconSize : 16,
          color: color != null ? color : iconColorSecondary),
      8.width,
      Text(
        location,
        style: isFontWeight == true
            ? boldTextStyle(
                size: size != null ? size : 14,
                color: color != null ? color : Booking_TextColorPrimary)
            : TextStyle(
                fontSize: size != null ? size.toDouble() : 14.0,
                color: color != null ? color : Booking_TextColorPrimary,
                fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      )
    ],
  );
}

Widget priceWrapper(
    {required double price,
    required String unit,
    required bool isFullScreen,
    MainAxisAlignment? alignment,
    bool? isFromText = true}) {
  return Row(
    mainAxisAlignment: alignment != null ? alignment : MainAxisAlignment.end,
    children: [
      if (isFromText == true)
        Text(
          'From',
          style: TextStyle(
            color: Booking_TextColorSecondary,
            fontWeight: FontWeight.w500,
            fontSize: isFullScreen == false ? textSizeSmall : textSizeSMedium,
          ),
        ),
      8.width,
      Text(
        '\$' + price.toString(),
        style: TextStyle(
          color: Booking_TextColorBlue,
          fontSize:
              isFullScreen == false ? textSizeMedium : textSizeLargeMedium,
          fontWeight: FontWeight.w800,
        ),
      ),
      8.width,
      Text(
        unit,
        style: TextStyle(
            color: Booking_TextColorSecondary,
            fontWeight: FontWeight.w500,
            fontSize: isFullScreen == false ? textSizeSMedium : textSizeMedium),
      ),
    ],
  );
}

Container statusBoxWidget(String status, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(borderRadius: radius(8), color: color),
    child: Text(
      status,
      style: boldTextStyle(
        color: Booking_TextColorWhite,
        size: 12,
        decoration: TextDecoration.none,
      ),
    ),
  );
}

Divider dividerWidget({Color? color}) {
  return Divider(
    color: color != null ? color : Booking_TextColorWhite,
    height: 20,
    thickness: 1.5,
  );
}

Container defaultCard(
    {required Widget child,
    double? width,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin}) {
  return Container(
    width: width != null ? width : SizeConfig.screenWidth,
    padding: padding != null ? padding : const EdgeInsets.all(0),
    margin: margin != null ? margin : const EdgeInsets.all(0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: radius(8),
      boxShadow: defaultBoxShadow(
        shadowColor: Booking_Primary.withOpacity(0.2),
        blurRadius: 4.0,
        spreadRadius: 0.4,
      ),
    ),
    child: child,
  );
}

Widget defaultButton(
    {Color? color,
    int? size,
    double? width,
    double? height,
    required String text,
    required VoidCallback tap}) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      width: width != null ? width : SizeConfig.screenWidth,
      height: height != null ? height : SizeConfig.screenHeight,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Booking_Secondary,
        borderRadius: radius(8),
        boxShadow: defaultBoxShadow(
          shadowColor: Booking_Secondary.withOpacity(0.4),
          blurRadius: 4.0,
          spreadRadius: 0.3,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16,
            color: Booking_TextColorWhite,
            decoration: TextDecoration.none),
      ),
    ),
  );
}

Widget commonCacheImageWidget(String? url, double height,
    {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder:
            placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorWidget: (_, __, ___) {
          return SizedBox(height: height, width: width);
        },
      );
    } else {
      return Image.network(url!,
          height: height, width: width, fit: fit ?? BoxFit.cover);
    }
  } else {
    return Image.asset(url!,
        height: height, width: width, fit: fit ?? BoxFit.cover);
  }
}

Widget? Function(BuildContext, String) placeholderWidgetFn() =>
    (_, s) => placeholderWidget();

Widget placeholderWidget() =>
    Image.asset('images/placeholder.jpg', fit: BoxFit.cover);


Container bottomBookNowWidget(BuildContext context,VoidCallback onTap,label) {
    return Container(
      color: Booking_Primary_light,
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  'From',
                  style: TextStyle(
                    color: Booking_Primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                10.height,
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      '\$300',
                      style: TextStyle(
                        color: Booking_Secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                     label,
                      style: TextStyle(
                        color: Booking_TextColorSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: context.width() / 2,
                height: 50,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Booking_Secondary,
                  borderRadius: radius(8),
                  boxShadow: defaultBoxShadow(
                    shadowColor: Booking_Secondary.withOpacity(0.4),
                    blurRadius: 4.0,
                    spreadRadius: 0.3,
                  ),
                ),
                child: Text(
                  Booking_lbl_BookNow,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Booking_TextColorWhite,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
    );
  }

  