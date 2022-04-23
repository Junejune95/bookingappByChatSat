import 'package:bookingapp/constants.dart';
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

Future<bool> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: unused_local_variable
  var bearToken = 'Bearer ' + (prefs.getString('access_token') ?? "");
  var url = Uri.parse(baseUrl + '/auth/register');
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "Authorization": bearToken
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse.toString());
    // prefs.setString('access_token', jsonResponse['access_token']);

    return true;
  } else {
    return false;
  }
}
