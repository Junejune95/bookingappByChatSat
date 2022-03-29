import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<HomePageModel> getHomeData() async {
  var url = Uri.parse('http://dev.bookingcore.org/api/home-page');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<BookingHotelModel> hotelmodelList = [];
    HomePageModel homePageModel =
        // ignore: unnecessary_new
        new HomePageModel(hotellist: [], title: '', subtitle: '');
    jsonResponse['data'][2]['model']['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      BookingHotelModel bookingHotelModel = new BookingHotelModel(
          id: val['id'],
          rating: double.parse(val['review_score']['score_total']),
          name: val['title'],
          reviewer: val['review_score']['total_review'],
          reviewstatus: val['review_score']['review_text'],
          image: val['image'],
          location: val['location']['name'],
          price: double.parse(val['price']),
          title: jsonResponse['data'][2]['model']['title'],
          subtitle: jsonResponse['data'][2]['model']['desc']);
      hotelmodelList.add(bookingHotelModel);
    });
    homePageModel.title = jsonResponse['data'][0]['model']['title'];
    homePageModel.subtitle = jsonResponse['data'][0]['model']['sub_title'];
    homePageModel.hotellist = hotelmodelList;
    return homePageModel;
  } else {
    HomePageModel homePageModel =
        // ignore: unnecessary_new
        new HomePageModel(hotellist: [], title: '', subtitle: '');
    return homePageModel;
  }
}
