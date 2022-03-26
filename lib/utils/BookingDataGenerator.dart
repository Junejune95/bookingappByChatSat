
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:bookingapp/utils/BookingStrings.dart';

import '../models/BookingIconModel.dart';

List<BookingTypeModel> getBookingTypeList() {
  List<BookingTypeModel> list = [];

  list.add(BookingTypeModel(icon:Booking_ic_hotel, name: Booking_lbl_Hotel,isSelected: false));
  list.add(BookingTypeModel(icon:Booking_ic_space, name: Booking_lbl_Space,isSelected: false));
  list.add(BookingTypeModel(icon:Booking_ic_tour, name: Booking_lbl_Tour,isSelected: false));
  list.add(BookingTypeModel(icon:Booking_ic_car, name: Booking_lbl_Car,isSelected: false));
  list.add(BookingTypeModel(icon:Booking_ic_fight, name: Booking_lbl_Fight,isSelected: false));


  return list;
}