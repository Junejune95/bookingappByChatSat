class BookingHotelModel {
  double rating;
  int reviewer;
  String reviewstatus;
  String name;
  String location;
  double price;
  String image;

  BookingHotelModel(
      {required this.rating,
      required this.name,
      required this.reviewer,
      required this.reviewstatus,
      required this.image,
      required this.location,
      required this.price});
}
