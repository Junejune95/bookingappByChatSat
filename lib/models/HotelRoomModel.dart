// ignore: file_names
import 'package:bookingapp/models/CommonModel.dart';

class HotelRoomModel {
  int id;
  String title;
  String size;
  String beds;
  String adults;
  String children;
  List<TypeSelectedModel>? facilitylist;
  double price;
  int available_no;
  List<String>? price_list;
  List<double>? prices;
  int? number_selected;

  HotelRoomModel(
      {required this.id,
      required this.title,
      required this.size,
      required this.beds,
      required this.adults,
      required this.children,
      this.facilitylist,
      required this.price,
      required this.available_no,
      this.price_list,
      this.prices,
      this.number_selected});
  factory HotelRoomModel.fromJson(Map<String, dynamic> json) {
    return HotelRoomModel(
      id: json['id'],
      title: json['title'],
      size: json['size_html'],
      beds: json['beds_html'],
      adults: json['adults_html'],
      children: json['children_html'],
      facilitylist: json['facility'],
      price: json['price'],
      available_no: json['number'],
      price_list: json['price_list'],
      number_selected: json['number_selected'] ?? 0,
      prices: json['prices'],
    );
  }
}
