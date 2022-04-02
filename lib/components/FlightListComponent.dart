// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bookingapp/components/RatingComponent.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/size_config.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FlightListComponent extends StatelessWidget {
  FlightListComponent({ Key? key, required this.flightlist})
      : super(key: key);

  final List<FlightModel> flightlist;

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}