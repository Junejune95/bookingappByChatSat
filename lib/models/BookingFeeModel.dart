class BookingFeeModel {
  String name;
  String desc;
  String price;
  BookingFeeModel(
      {required this.name, required this.desc, required this.price});
  factory BookingFeeModel.fromJson(Map<String, dynamic> json) {
    return BookingFeeModel(
        name: json['name'], desc: json['desc'], price: json['price']);
  }
}
