class FlightModel {
  int id;
  double price;
  String departuretime, arrivaltime, saleprice, content, image, title, duration;

  FlightModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
    required this.price,
    required this.saleprice,
    required this.departuretime,
    required this.arrivaltime,
    required this.duration,
  });
  // factory FlightModel.fromJson(Map<String, dynamic> json) {
  //   return FlightModel(
  //     id: json['id'],
  //     title: json['title'],
  //     image: json['image'],
  //     content: json['content'],
  //     reviewer: json['reviewer'],
  //     reviewstatus: json['reviewstatus'],
  //     price: json['price'],
  //     saleprice: json['sale_price'],
  //     code: json['code'],
  //   );
  // }
}
