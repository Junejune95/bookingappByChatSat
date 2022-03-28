import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:bookingapp/utils/BookingStrings.dart';

import '../models/BookingIconModel.dart';

List<BookingTypeModel> getBookingTypeList() {
  List<BookingTypeModel> list = [];

  list.add(BookingTypeModel(icon: Booking_ic_hotel, name: Booking_lbl_Hotel));
  list.add(BookingTypeModel(icon: Booking_ic_space, name: Booking_lbl_Space));
  list.add(BookingTypeModel(icon: Booking_ic_tour, name: Booking_lbl_Tour));
  list.add(BookingTypeModel(icon: Booking_ic_car, name: Booking_lbl_Car));
  list.add(BookingTypeModel(icon: Booking_ic_fight, name: Booking_lbl_Fight));

  return list;
}

List<BookingHotelModel> getHotelList() {
  List<BookingHotelModel> list = [];

  // list.add(BookingHotelModel(rating: 4.8, name: 'Hotel Stanford', reviewer: 10, reviewstatus: 'Excellent', image: 'https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg', location: 'Paris', price: 350));
  // list.add(BookingHotelModel(rating: 4, name: 'Hotel WBF Hommachi', reviewer: 6, reviewstatus: 'Very Good', image: 'https://cdn.britannica.com/96/115096-050-5AFDAF5D/Bellagio-Hotel-Casino-Las-Vegas.jpg', location: 'Paris', price: 350));
  // list.add(BookingHotelModel(rating: 4.5, name: 'Castello Casole Hotel', reviewer: 8, reviewstatus: 'Excellent', image: 'https://www.luxuryabode.com/mona/img/hotels.jpg', location: 'Paris', price: 350));

  return list;
}
