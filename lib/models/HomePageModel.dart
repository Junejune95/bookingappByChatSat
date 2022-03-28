import 'package:bookingapp/models/BookingCommonModel.dart';

class HomePageModel {
  String title, subtitle;
  List<BookingHotelModel> hotellist;

  HomePageModel(
      {required this.hotellist, required this.title, required this.subtitle});
  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
        title: json['title'],
        subtitle: json['sub_title'],
        hotellist: (json['hotel'] as List)
            .map((data) => BookingHotelModel.fromJson(data))
            .toList());
  }
}
