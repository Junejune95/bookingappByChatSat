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

  CarModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.location,
    required this.rating,
    required this.reviewer,
    required this.reviewstatus,
    required this.price,
  });
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
        price: json['price']);
  }
}
