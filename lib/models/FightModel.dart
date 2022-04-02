class FlightModel {
  int id;
  int reviewer;
  double price;
  String departuretime,
      arrivaltime,
      saleprice,
      reviewstatus,
      content,
      image,
      code,
      title,
      duration;

  FlightModel({
    required this.id,
    required this.code,
    required this.title,
    required this.image,
    required this.content,
    required this.reviewer,
    required this.reviewstatus,
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
