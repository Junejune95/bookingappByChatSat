import 'package:bookingapp/models/CommonModel.dart';

class FligthFilterModel {
  int minprice, maxprice;
  List<TypeSelectedModel> flighttypelist;
  List<TypeSelectedModel> inflightexplist;
  FligthFilterModel({
    required this.minprice,
    required this.maxprice,
    required this.flighttypelist,
    required this.inflightexplist,
  });
  factory FligthFilterModel.fromJson(Map<String, dynamic> json) {
    return FligthFilterModel(
        minprice: json['minprice'],
        maxprice: json['maxprice'],
        flighttypelist: json['flighttype'],
        inflightexplist: json['exp']);
  }
}
