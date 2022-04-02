import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<FlightModel>> getFlightData(String params) async {
  var url = Uri.parse(baseUrl + '/flight/search?' + params);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<FlightModel> flightmodelList = [];
    jsonResponse['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      FlightModel flightModel = new FlightModel(
          id: val['id'],
          title: val['title'],
          image: val['image'] ?? "",
          content: val['content'] ?? "",
          price: val['price'] ?? 0.0,
          saleprice: val['sale_price'] ?? 0.0,
          departuretime: "",
          arrivaltime: "",
          duration: "",
          location: val['location'] ?? "");
      flightmodelList.add(flightModel);
    });
    return flightmodelList;
  } else {
    return [];
  }
}
