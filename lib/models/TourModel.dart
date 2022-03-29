class TourModel {
  int id;
  String title;
  String image;
  String content;
  String location;
  double rating;
  int reviewer;
  double price;
  double saleprice;

  TourModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.content,
      required this.location,
      required this.rating,
      required this.reviewer,
      required this.price,
      required this.saleprice});
  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        content: json['content'],
        reviewer: json['reviewer'],
        rating: json['rating'],
        location: json['location'],
        price: json['price'],
        saleprice: json['sale_price']);
  }
}
