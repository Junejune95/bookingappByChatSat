import 'package:bookingapp/models/BookingFeeModel.dart';

class BookingHis {
  String serviceTitle,
      gateway,
      total,
      total_guests,
      status,
      first_name,
      last_name;
  String email;
  int id;
  bool isPaid;
  String address,
      address2,
      phone,
      city,
      state,
      zipcode,
      start_date,
      end_date,
      paid,
      type;
  List<BookingFeeModel> buyer_fees;
  BookingHis(
      {required this.serviceTitle,
      required this.gateway,
      required this.first_name,
      required this.last_name,
      required this.total,
      required this.email,
      required this.id,
      required this.address,
      required this.address2,
      required this.city,
      required this.state,
      required this.zipcode,
      required this.start_date,
      required this.end_date,
      required this.total_guests,
      required this.status,
      required this.phone,
      required this.isPaid,
      required this.paid,
      required this.type,
      required this.buyer_fees});
  factory BookingHis.fromJson(Map<String, dynamic> json) {
    return BookingHis(
        serviceTitle: json['service'],
        gateway: json['gateway'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        total: json['total'],
        email: json['email'],
        id: json['id'],
        address: json['address'],
        address2: json['address2'] ?? "",
        city: json['city'],
        state: json['state'],
        zipcode: json['zip_code'] != null ? json['zip_code'].toString() : "",
        start_date: json['start_date'],
        end_date: json['end_date'],
        total_guests: json['total_guests'].toString(),
        status: json['status'],
        phone: json['phone'],
        paid: json['paid'] ?? "0",
        type: json['object_model'],
        isPaid: json['is_paid'] ?? false,
        buyer_fees: json['buyer_fees']);
  }
}
