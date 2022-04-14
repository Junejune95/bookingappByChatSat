// ignore: file_names
import 'package:bookingapp/models/CommonModel.dart';

class HotelRoomModel {
  String title;
  String size;
  String beds;
  String adults;
  String children;
  List<TypeSelectedModel>? facilitylist;

  HotelRoomModel({
    required this.title,
    required this.size,
    required this.beds,
    required this.adults,
    required this.children,
    this.facilitylist,
  });
  factory HotelRoomModel.fromJson(Map<String, dynamic> json) {
    return HotelRoomModel(
      title: json['title'],
      size: json['size_html'],
      beds: json['beds_html'],
      adults: json['adults_html'],
      children: json['children_html'],
      facilitylist: json['facility'],
    );
  }
}
