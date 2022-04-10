import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingImagePreviewScreen extends StatefulWidget {
  BookingImagePreviewScreen({Key? key, required this.images}) : super(key: key);

  final List<String> images;

  @override
  State<BookingImagePreviewScreen> createState() =>
      _BookingImagePreviewScreenState();
}

class _BookingImagePreviewScreenState extends State<BookingImagePreviewScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        width: context.width(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.images[selectedIndex]),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,
              top: 60,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Booking_Secondary_light.withOpacity(0.3),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Booking_ic_back,
                    color: Booking_TextColorWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(height: 160, child: listview()),
    );
  }

  Widget listview() {
    List<Widget> imgList = widget.images
        .map((e) => Image.network(e))
        .map(
          (e) => Container(
            margin: EdgeInsets.only(bottom: 60),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              image: e.image,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ).cornerRadiusWithClipRRect(10),
          ),
        )
        .toList();

    return HorizontalList(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      spacing: 16,
      itemCount: widget.images.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => {
            setState(() {
              selectedIndex = index;
            })
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: index == selectedIndex
                    ? Border.all(
                        color: Booking_TextColorBlue,
                        width: 3,
                      )
                    : Border.all(width: 0)),
            child: commonCacheImageWidget(
              widget.images[index],
             index == selectedIndex ? 130 : 120,
              width:  index == selectedIndex ? 130 : 120,
            ).cornerRadiusWithClipRRect(10),
          ),
        );
      },
    );
  }
}
