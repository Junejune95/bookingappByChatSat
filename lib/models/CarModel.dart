import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/FAQModel.dart';

class CarModel {
  int id;
  String title;
  String image;
  String content;
  String location;
  double rating;
  int reviewer;
  String reviewstatus;
  double price;
  int passenger, baggage, door;
  String gear;
  List<String>? gallery;
  List<FAQModel>? faqlist;
  List<BookingFeeModel>? bookingfee;
  List<BookingFeeModel>? extrafee;
  List<String>? featurelist;

  CarModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.content,
      required this.location,
      required this.rating,
      required this.reviewer,
      required this.reviewstatus,
      required this.price,
      required this.passenger,
      required this.baggage,
      required this.door,
      required this.gear,
      this.gallery,
      this.faqlist,
      this.bookingfee,
      this.extrafee,
      this.featurelist});
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      content: json['content'],
      reviewer: json['reviewer'],
      reviewstatus: json['reviewstatus'],
      rating: json['rating'],
      location: json['location'],
      price: json['price'],
      passenger: json['passenger'],
      baggage: json['baggage'],
      door: json['door'],
      gear: json['gear'],
      gallery: json['gallery'],
      faqlist: json['faq'],
      bookingfee: json['bookingfee'],
      extrafee: json['extrafee'],
      featurelist: json['features'],
    );
  }
}
