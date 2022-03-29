class BookingHotelModel {
  int id;
  double rating;
  int reviewer;
  String reviewstatus;
  String name;
  String location;
  double price;
  String image;

  BookingHotelModel({
    required this.id,
    required this.rating,
    required this.name,
    required this.reviewer,
    required this.reviewstatus,
    required this.image,
    required this.location,
    required this.price,
  });
  factory BookingHotelModel.fromJson(Map<String, dynamic> json) {
    return BookingHotelModel(
        id: json['id'],
        rating: json['rating'],
        name: json['name'],
        reviewer: json['reviewer'],
        reviewstatus: json['reviewstatus'],
        image: json['image'],
        location: json['location'],
        price: json['price']);
  }
}
