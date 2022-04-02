import 'package:bookingapp/models/CarModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<List<CarModel>> getCarData(String params) async {
  var url = Uri.parse('http://dev.bookingcore.org/api/car/search?' + params);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<CarModel> carmodelList = [];
    jsonResponse['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      CarModel carModel = new CarModel(
        id: val['id'],
        rating: double.parse(val['review_score']['score_total']),
        title: val['title'],
        reviewer: val['review_score']['total_review'],
        reviewstatus: val['review_score']['review_text'],
        image: val['image'],
        location: val['location']['name'],
        price: double.parse(val['price'].toString()),
        content: val['content'],
        passenger: val['passenger'],
        baggage: val['baggage'],
        door: val['door'],
        gear: val['gear'],
      );
      carmodelList.add(carModel);
    });
    return carmodelList;
  } else {
    return [];
  }
}