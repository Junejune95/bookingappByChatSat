class UserModel {
  String name, first_name, last_name;
  String email;
  int id;
  String address, address2, phone, city, state, zipcode, created_at;
  UserModel(
      {required this.name,
      required this.first_name,
      required this.last_name,
      required this.email,
      required this.id,
      required this.address,
      required this.address2,
      required this.city,
      required this.state,
      required this.zipcode,
      required this.created_at,
      required this.phone});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      id: json['id'],
      address: json['address'],
      address2: json['address2'] ?? "",
      city: json['city'],
      state: json['state'],
      zipcode: json['zip_code'] != null ? json['zip_code'].toString() : "",
      created_at: json['created_at'],
      phone: json['phone'],
    );
  }
}
