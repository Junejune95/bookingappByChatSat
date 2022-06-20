import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/BookingHisModel.dart';
import 'package:bookingapp/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> userLogin(String email, String password) async {
  var url = Uri.parse(baseUrl + '/auth/login');
  var body = convert.jsonEncode({"email": email, "password": password});
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    prefs.setString('access_token', jsonResponse['access_token']);

    return true;
  } else {
    return false;
  }
}

Future<bool> userRegister(String email, String password, String firstName,
    String lastName, String phoneNumber) async {
  var url = Uri.parse(baseUrl + '/auth/register');
  var body = convert.jsonEncode({
    "email": email,
    "password": password,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "term": "1"
  });
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    prefs.setString('access_token', jsonResponse['access_token']);

    return true;
  } else {
    return false;
  }
}

Future<UserModel> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  var bearToken = 'Bearer ' + (prefs.getString('access_token') ?? "");
  var url = Uri.parse(baseUrl + '/auth/me');
  try {
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": bearToken
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      jsonResponse['data']['name'] = jsonResponse['data']['first_name'] +
          " " +
          jsonResponse['data']['last_name'];
      UserModel userModel = UserModel.fromJson(jsonResponse['data']);

      return userModel;
    } else {
      UserModel userModel = UserModel(
          name: "",
          first_name: "",
          last_name: "",
          email: "",
          id: 0,
          address: "",
          address2: "",
          city: "",
          state: "",
          zipcode: "",
          created_at: "",
          phone: "");
      return userModel;
    }
    // ignore: nullable_type_in_catch_clause
  } on Exception catch (_, e) {
    UserModel userModel = UserModel(
        name: "",
        first_name: "",
        last_name: "",
        email: "",
        id: 0,
        address: "",
        address2: "",
        city: "",
        state: "",
        zipcode: "",
        created_at: "",
        phone: "");
    return userModel;
  }
}

Future<bool> refreshToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  var bearToken = 'Bearer ' + (prefs.getString('access_token') ?? "");
  var url = Uri.parse(baseUrl + '/auth/refresh');
  try {
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Authorization": bearToken
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      prefs.setString('access_token', jsonResponse['access_token']);

      return true;
    } else {
      return false;
    }
    // ignore: nullable_type_in_catch_clause
  } finally {}
}

Future<List<BookingHis>> userBookingHis(String status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  var bearToken = 'Bearer ' + (prefs.getString('access_token') ?? "");
  var url = Uri.parse(baseUrl + '/user/booking-history?status=' + status);
  try {
    // var body = convert.jsonEncode({"status": status ?? ""});
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": bearToken
    });

    List<BookingHis> bookingHisList = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.toString());
      jsonResponse['data'].forEach((val) {
        val['service'] = val['service']['title'];
        List<BookingFeeModel> fee = [];
        val['buyer_fees'].forEach((buyer) {
          buyer['desc'] = "";
          fee.add(BookingFeeModel.fromJson(buyer));
        });
        val['buyer_fees'] = fee;
        BookingHis bookingHis = BookingHis.fromJson(val);
        bookingHisList.add(bookingHis);
      });

      return bookingHisList;
    } else {
      List<BookingHis> bookingHisList = [];
      return bookingHisList;
    }
    // ignore: nullable_type_in_catch_clause
  } on Exception catch (_, e) {
    List<BookingHis> bookingHisList = [];
    return bookingHisList;
  }
}
