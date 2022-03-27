import 'package:bookingapp/models/BookingCommonModel.dart';

class HomePageModel {
  List<BookingHotelModel> hotellist;

  HomePageModel({required this.hotellist});
  factory HomePageModel.fromJson(Map<String, dynamic> json) {
    return HomePageModel(
        hotellist: (json['hotel'] as List)
            .map((data) => BookingHotelModel.fromJson(data))
            .toList());
  }
}
