import 'package:bookingapp/models/CommonModel.dart';

class HotelFilterModel {
  int minprice, maxprice;
  List<TypeSelectedModel> propertylist;
  List<TypeSelectedModel> facilitylist;
  List<TypeSelectedModel> servicelist;
  HotelFilterModel({
    required this.minprice,
    required this.maxprice,
    required this.propertylist,
    required this.facilitylist,
    required this.servicelist,
  });
  factory HotelFilterModel.fromJson(Map<String, dynamic> json) {
    return HotelFilterModel(
      minprice: json['minprice'],
      maxprice: json['maxprice'],
      propertylist: json['property'],
      facilitylist: json['facility'],
      servicelist: json['service'],
    );
  }
}
