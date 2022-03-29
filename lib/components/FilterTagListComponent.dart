import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef intCallBack(int val);

class FilterTagListComponent extends StatefulWidget {
  const FilterTagListComponent(
      {Key? key,
      required this.typeList,
      required this.label,
      required this.isIcon,
      this.callback})
      : super(key: key);

  final List<TypeSelectedModel> typeList;
  final String label;
  final bool isIcon;
  final intCallBack? callback;

  @override
  State<FilterTagListComponent> createState() => _FilterTagListComponentState();
}

class _FilterTagListComponentState extends State<FilterTagListComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: labelText(title: widget.label),
        ),
        4.height,
        HorizontalList(
          itemCount: widget.typeList.length,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(8),
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(16),
                  backgroundColor: widget.typeList[i].isSelected == true
                      ? Booking_Secondary
                      : Booking_AppBar),
              child: widget.isIcon != true
                  ? Text(
                      widget.typeList[i].type!,
                      style: primaryTextStyle(
                          color: widget.typeList[i].isSelected == true
                              ? Booking_TextColorWhite
                              : Booking_TextColorPrimary),
                    )
                  : Icon(
                      widget.typeList[i].icon,
                      color: widget.typeList[i].isSelected == true
                          ? Booking_TextColorWhite
                          : Booking_TextColorPrimary,
                    ),
            ).onTap(() {
              widget.typeList[i].isSelected = !widget.typeList[i].isSelected;
              log(widget.typeList[i].isSelected);
              setState(() {
                widget.callback!(widget.typeList[i].id ?? 0);
              });
            });
          },
        ),
      ],
    );
  }
}
