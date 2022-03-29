import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<BookingHotelModel>> getHotelData() async {
  var url = Uri.parse('http://dev.bookingcore.org/api/hotel/search');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<BookingHotelModel> hotelmodelList = [];
    jsonResponse['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      BookingHotelModel bookingHotelModel = new BookingHotelModel(
          id: val['id'],
          rating: double.parse(val['review_score']['score_total']),
          name: val['title'],
          reviewer: val['review_score']['total_review'],
          reviewstatus: val['review_score']['review_text'],
          image: val['image'],
          location: val['location']['name'],
          price: double.parse(val['price']));
      hotelmodelList.add(bookingHotelModel);
    });

    return hotelmodelList;
  } else {
    return [];
  }
}
