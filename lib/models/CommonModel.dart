import 'package:flutter/material.dart';

class TypeSelectedModel {
  String? type;
  bool isSelected;
  IconData? icon;
  int? id;
  TypeSelectedModel({this.type, this.isSelected = false, this.icon, this.id});
}
