import 'package:flutter/material.dart';

class BookingFeeModel {
  String name;
  String desc;
  String price;
  bool? enabled;
  BookingFeeModel(
      {required this.name,
      required this.desc,
      required this.price,
      @optionalTypeArgs this.enabled});
  factory BookingFeeModel.fromJson(Map<String, dynamic> json) {
    return BookingFeeModel(
        name: json['name'],
        desc: json['desc'],
        price: json['price'],
        enabled: json['enabled'] ?? false);
  }
}
