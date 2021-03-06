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
      this.callback,
      this.labelColor})
      : super(key: key);

  final List<TypeSelectedModel> typeList;
  final String label;
  final bool isIcon;
  final Color? labelColor;
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
          child: labelText(
              title: widget.label,
              color: widget.labelColor != null ? widget.labelColor : null),
        ),
        4.height,
        HorizontalList(
          itemCount: widget.typeList.length,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  widget.typeList[i].isSelected =
                      !widget.typeList[i].isSelected;

                  setState(() {
                    widget.callback!(widget.typeList[i].id ?? 0);
                  });
                },
                child: tagrectWidget(
                    isIcon: widget.isIcon,
                    text: widget.typeList[i].type,
                    color: widget.typeList[i].isSelected == true
                        ? Booking_TextColorWhite
                        : Booking_TextColorPrimary,
                    bgColor: widget.typeList[i].isSelected == true
                        ? Booking_Secondary
                        : Booking_AppBar,
                    ic: widget.typeList[i].icon));
          },
        ),
      ],
    );
  }
}
