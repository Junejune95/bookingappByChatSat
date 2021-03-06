import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/CarFilterModel.dart';
import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/models/FAQModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<CarModel>> getCarData(String params) async {
  var url = Uri.parse(baseUrl + '/car/search?' + params);
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

Future<CarFilterModel> getCarFilter() async {
  var url = Uri.parse(baseUrl + '/car/filters');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    // ignore: unnecessary_new
    CarFilterModel carFilterModel = new CarFilterModel(
        minprice: 0, maxprice: 0, cartypelist: [], featurelist: []);
    List<TypeSelectedModel> cartypelist = [];
    List<TypeSelectedModel> featurelist = [];
    carFilterModel.minprice = jsonResponse['data'][0]['min_price'];
    carFilterModel.maxprice = jsonResponse['data'][0]['max_price'];
    jsonResponse['data'][2]['data'][0]['terms'].forEach((dynamic val) {
      TypeSelectedModel property =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      cartypelist.add(property);
    });
    jsonResponse['data'][2]['data'][1]['terms'].forEach((dynamic val) {
      TypeSelectedModel facility =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      featurelist.add(facility);
    });

    carFilterModel.featurelist = featurelist;
    carFilterModel.cartypelist = cartypelist;
    return carFilterModel;
  } else {
    // ignore: unnecessary_new
    CarFilterModel carFilterModel = new CarFilterModel(
        minprice: 0, maxprice: 0, cartypelist: [], featurelist: []);
    return carFilterModel;
  }
}

Future<CarModel?> getCarDetail(String id) async {
  var url = Uri.parse(baseUrl + '/car/detail/' + id);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var data = convert.jsonDecode(response.body);
    var val = data['data'];
    List<FAQModel> faqlist = [];
    List<BookingFeeModel> bookingfee = [];
    List<BookingFeeModel> extrafee = [];
    List<String> gallery = [];
    List<String> features = [];
    val['faqs'].forEach((dynamic val) {
      FAQModel faqModel = FAQModel.fromJson(val);
      faqlist.add(faqModel);
    });
    val['booking_fee'].forEach((dynamic val) {
      BookingFeeModel bookingFeeModel = BookingFeeModel.fromJson(val);
      bookingfee.add(bookingFeeModel);
    });
    val['extra_price'].forEach((dynamic val) {
      val['desc'] = '';
      BookingFeeModel bookingFeeModel = BookingFeeModel.fromJson(val);
      extrafee.add(bookingFeeModel);
    });
    val['gallery'].forEach((dynamic val) {
      gallery.add(val);
    });
    val['terms']['10']['child'].forEach((dynamic val) {
      features.add(val['title']);
    });

    CarModel carModel = CarModel(
        id: val['id'],
        rating: double.parse(val['review_score']['score_total']),
        title: val['title'],
        reviewer: val['review_score']['total_review'],
        reviewstatus: val['review_score']['score_text'],
        image: val['image'],
        location: val['location']['name'],
        price: double.parse(val['price'].toString()),
        content: '<h4>Description</h4>' + val['content'],
        passenger: val['passenger'],
        baggage: val['baggage'],
        door: val['door'],
        gear: val['gear'],
        faqlist: faqlist,
        gallery: gallery,
        featurelist: features,
        bookingfee: bookingfee,
        extrafee: extrafee);
    return carModel;
  } else {
    return null;
  }
}
