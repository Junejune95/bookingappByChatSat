import 'package:flutter/material.dart';

class BookingLoadingComponent extends StatelessWidget {
  double height;
  double width;

  BookingLoadingComponent({Key? key, required this.height,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 2,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
