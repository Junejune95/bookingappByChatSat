import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:flutter/material.dart';

class BookingHotelModel {
  int id;
  double rating;
  int reviewer;
  String reviewstatus;
  String name;
  String location;
  double price;
  String image;
  String? content;
  List<TypeSelectedModel>? facilitylist;
  List<String>? gallaries;
  String? video;
  String? gpolicy, cpolicy, capolicy, lcopolicy;
  List<BookingFeeModel>? extra_price, booking_fee;

  BookingHotelModel(
      {required this.id,
      required this.rating,
      required this.name,
      required this.reviewer,
      required this.reviewstatus,
      required this.image,
      required this.location,
      required this.price,
      this.content,
      this.facilitylist,
      this.gallaries,
      this.video,
      this.gpolicy,
      this.cpolicy,
      this.capolicy,
      this.lcopolicy,
      this.extra_price,
      this.booking_fee});
  factory BookingHotelModel.fromJson(Map<String, dynamic> json) {
    return BookingHotelModel(
      id: json['id'],
      rating: json['rating'],
      name: json['name'],
      reviewer: json['reviewer'],
      reviewstatus: json['reviewstatus'],
      image: json['image'],
      location: json['location'],
      price: json['price'],
      content: json['content'],
      facilitylist: json['facility'],
      gallaries: json['gallery'],
      video: json['video'],
      gpolicy: json['gpolicy'],
      cpolicy: json['cpolicy'],
      capolicy: json['capolicy'],
      extra_price: json['extra_price'],
      booking_fee: json['booking_fee'],
      lcopolicy: json['lcopolicy'],
    );
  }
}
