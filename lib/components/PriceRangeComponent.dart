import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceRangeComponent extends StatefulWidget {
  PriceRangeComponent({Key? key}) : super(key: key);

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
                min: 300,
                max: 900,
                divisions: 300,
                labels: RangeLabels(
                  '\$' + _currentRangeValues.start.round().toString(),
                  '\$' + _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
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
