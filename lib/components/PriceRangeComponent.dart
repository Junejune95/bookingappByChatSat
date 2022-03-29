import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

typedef StringCallBack(String val);

class PriceRangeComponent extends StatefulWidget {
  PriceRangeComponent(
      {Key? key, required this.minprice, required this.maxprice, this.callback})
      : super(key: key);
  final int minprice, maxprice;
  final StringCallBack? callback;
  @override
  State<PriceRangeComponent> createState() => _PriceRangeComponentState();
}

class _PriceRangeComponentState extends State<PriceRangeComponent> {
  RangeValues _currentRangeValues = const RangeValues(300, 900);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText(title: 'Filter Price'),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            rangeLabelWidget(_currentRangeValues.start.round().toString()),
            Expanded(
              child: RangeSlider(
                activeColor: Booking_Secondary,
                values: _currentRangeValues,
                min: widget.minprice.toDouble(),
                max: widget.maxprice.toDouble(),
                divisions: 300,
                labels: RangeLabels(
                  '\$' + _currentRangeValues.start.round().toString(),
                  '\$' + _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    widget.callback!(_currentRangeValues.start.toString() +
                        ";" +
                        _currentRangeValues.end.toString());
                    _currentRangeValues = values;
                  });
                },
              ),
            ),
            rangeLabelWidget(_currentRangeValues.end.round().toString()),
          ],
        ),
      ],
    );
  }

  Text rangeLabelWidget(range) {
    return Text(
      '\$' + range,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Booking_TextColorSecondary,
      ),
    );
  }
}
