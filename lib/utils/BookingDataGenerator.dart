import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';

import '../models/BookingIconModel.dart';

List<BookingTypeModel> getBookingTypeList() {
  List<BookingTypeModel> list = [];

  list.add(BookingTypeModel(icon: Booking_ic_hotel, name: Booking_lbl_Hotel));
  // list.add(BookingTypeModel(icon: Booking_ic_space, name: Booking_lbl_Space));
  // list.add(BookingTypeModel(icon: Booking_ic_tour, name: Booking_lbl_Tour));
  list.add(BookingTypeModel(icon: Booking_ic_car, name: Booking_lbl_Car));
  list.add(BookingTypeModel(icon: Booking_ic_fight, name: Booking_lbl_Fight));

  return list;
}

List<TypeSelectedModel> propertyTypeList = [
  TypeSelectedModel(type: "Apartments", isSelected: false),
  TypeSelectedModel(type: "Hotels", isSelected: false),
  TypeSelectedModel(type: "Homestays", isSelected: false),
  TypeSelectedModel(type: "Villas", isSelected: false),
  TypeSelectedModel(type: "Boats", isSelected: false),
  TypeSelectedModel(type: "Motels", isSelected: false),
  TypeSelectedModel(type: "Resorts", isSelected: false),
  TypeSelectedModel(type: "Lodges", isSelected: false),
  TypeSelectedModel(type: "Holiday homes", isSelected: false),
  TypeSelectedModel(type: "Cruises", isSelected: false),
];

List<TypeSelectedModel> facilitiesList = [
  TypeSelectedModel(icon: Booking_ic_wakeupcall, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_car, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_bike, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_tv, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_recycle, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_wifi, isSelected: false),
  TypeSelectedModel(icon: Booking_ic_coffee, isSelected: false),
];

List<TypeSelectedModel> hotelServiceList = [
  TypeSelectedModel(type: "Havana Lobby bar", isSelected: false),
  TypeSelectedModel(type: "Fiesta Restaurant", isSelected: false),
  TypeSelectedModel(type: "Hotel transport services", isSelected: false),
  TypeSelectedModel(type: "Free luggage deposit", isSelected: false),
  TypeSelectedModel(type: "Laundry Services", isSelected: false),
  TypeSelectedModel(type: "Pets welcome", isSelected: false),
  TypeSelectedModel(type: "Tickets", isSelected: false),
];
