import 'package:bookingapp/models/CommonModel.dart';

class CarFilterModel {
  int minprice, maxprice;
  List<TypeSelectedModel> cartypelist;
  List<TypeSelectedModel> featurelist;
  CarFilterModel({
    required this.minprice,
    required this.maxprice,
    required this.cartypelist,
    required this.featurelist,
  });
  factory CarFilterModel.fromJson(Map<String, dynamic> json) {
    return CarFilterModel(
        minprice: json['minprice'],
        maxprice: json['maxprice'],
        cartypelist: json['cartype'],
        featurelist: json['feature']);
  }
}
