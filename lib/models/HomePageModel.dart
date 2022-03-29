import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/DestinationModel.dart';

class HomePageModel {
  String title, subtitle;
  String htitle, hsubtitle;
  List<BookingHotelModel> hotellist;
  String dtitle, dsubtitle;
  List<DistinationModel> distlist;

  HomePageModel({
    required this.hotellist,
    required this.title,
    required this.subtitle,
    required this.htitle,
    required this.hsubtitle,
    required this.distlist,
    required this.dtitle,
    required this.dsubtitle,
  });
  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
      title: json['title'],
      subtitle: json['sub_title'],
      htitle: json['htitle'],
      hsubtitle: json['hsubtitle'],
      hotellist: (json['hotel'] as List)
          .map((data) => BookingHotelModel.fromJson(data))
          .toList(),
      distlist: (json['hotel'] as List)
          .map((data) => DistinationModel.fromJson(data))
          .toList(),
      dtitle: json['dtitle'],
      dsubtitle: json['dsubtitle'],
    );
  }
}
