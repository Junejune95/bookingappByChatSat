class BookingHotelModel {
  double rating;
  int reviewer;
  String reviewstatus;
  String name;
  String location;
  double price;
  String image;
  String title;
  String subtitle;

  BookingHotelModel(
      {required this.rating,
      required this.name,
      required this.reviewer,
      required this.reviewstatus,
      required this.image,
      required this.location,
      required this.price,
      required this.title,
      required this.subtitle});
  factory BookingHotelModel.fromJson(Map<String, dynamic> json) {
    return BookingHotelModel(
      rating: json['rating'],
      name: json['name'],
      reviewer: json['reviewer'],
      reviewstatus: json['reviewstatus'],
      image: json['image'],
      location: json['location'],
      price: json['price'],
      title: json['title'],
      subtitle: json['sub_title'],
    );
  }
}
