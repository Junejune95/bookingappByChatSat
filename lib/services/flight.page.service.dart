import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/models/FlightFliterModel.dart';
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
          price: val['price'] != null ? double.parse(val['price']) : 0.0,
          saleprice: val['sale_price'] ?? "",
          departuretime: val['departure_time'],
          arrivaltime: val['arrival_time'],
          duration: val['duration'],
          location_from: val['location_from']['name'] ?? "",
          location_to: val['location_to']['name'] ?? "",
          airport_from: '',
          airport_to: '');
      flightmodelList.add(flightModel);
    });
    print("GGG");
    return flightmodelList;
  } else {
    return [];
  }
}

Future<FligthFilterModel> getFlightFilter() async {
  var url = Uri.parse(baseUrl + '/flight/filters');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    // ignore: unnecessary_new
    FligthFilterModel carFilterModel = new FligthFilterModel(
        minprice: 0, maxprice: 0, flighttypelist: [], inflightexplist: []);
    List<TypeSelectedModel> flighttypelist = [];
    List<TypeSelectedModel> explist = [];
    carFilterModel.minprice = jsonResponse['data'][0]['min_price'];
    carFilterModel.maxprice = jsonResponse['data'][0]['max_price'];
    jsonResponse['data'][1]['data'][0]['terms'].forEach((dynamic val) {
      TypeSelectedModel property =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      flighttypelist.add(property);
    });
    jsonResponse['data'][1]['data'][1]['terms'].forEach((dynamic val) {
      TypeSelectedModel facility =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      explist.add(facility);
    });

    carFilterModel.flighttypelist = flighttypelist;
    carFilterModel.inflightexplist = explist;
    return carFilterModel;
  } else {
    // ignore: unnecessary_new
    FligthFilterModel carFilterModel = new FligthFilterModel(
        minprice: 0, maxprice: 0, flighttypelist: [], inflightexplist: []);
    return carFilterModel;
  }
}

Future<FlightModel?> getFlightDetail(String id) async {
  var url = Uri.parse(baseUrl + '/flight/getData/' + id);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});
  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    // ignore: unnecessary_new
    List<FlighSeattModel> seats = [];
    jsonResponse['data']['flight_seat'].forEach((dynamic val) {
      val['max_passengers'] = val['max_passengers'].toString();
      val['baggage_check_in'] = val['baggage_check_in'].toString();
      val['baggage_cabin'] = val['baggage_cabin'].toString();
      val['price'] = double.parse(val['price']);
      val['seattypes'] = val['seat_type'];
      seats.add(FlighSeattModel.fromJson(val));
    });
    jsonResponse['data']['seats'] = seats;
    jsonResponse['data']['image'] = jsonResponse['data']['image'] ?? "";
    jsonResponse['data']['airport_from'] =
        jsonResponse['data']['airport_from']!['name'] ?? "";
    jsonResponse['data']['airport_to'] =
        jsonResponse['data']['airport_to']!['name'] ?? "";
    FlightModel flightModel = FlightModel.fromJson(jsonResponse['data']);
    return flightModel;
  } else {
    // ignore: unnecessary_new
    // return null;
    return null;
  }
}
