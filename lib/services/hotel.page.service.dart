import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/BookingFeeModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/models/HotelFilterModel.dart';
import 'package:bookingapp/models/HotelRoomModel.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

Future<List<BookingHotelModel>> getHotelData(String params) async {
  var url = Uri.parse(baseUrl + '/hotel/search?' + params);
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

Future<HotelFilterModel> getHotelFilter() async {
  var url = Uri.parse(baseUrl + '/hotel/filters');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    // ignore: unnecessary_new
    HotelFilterModel hotelFilterModel = new HotelFilterModel(
        minprice: 0,
        maxprice: 0,
        propertylist: [],
        facilitylist: [],
        servicelist: []);
    List<TypeSelectedModel> propertylist = [];
    List<TypeSelectedModel> facilitylist = [];
    List<TypeSelectedModel> servicelist = [];
    hotelFilterModel.minprice = jsonResponse['data'][0]['min_price'];
    hotelFilterModel.maxprice = jsonResponse['data'][0]['max_price'];
    jsonResponse['data'][3]['data'][0]['terms'].forEach((dynamic val) {
      TypeSelectedModel property =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      propertylist.add(property);
    });
    jsonResponse['data'][3]['data'][1]['terms'].forEach((dynamic val) {
      TypeSelectedModel facility =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      facility.id == 42
          ? facility.icon = Booking_ic_wakeupcall
          : facility.id == 43
              ? facility.icon = Booking_ic_car
              : facility.id == 44
                  ? facility.icon = Booking_ic_bike
                  : facility.id == 45
                      ? facility.icon = Booking_ic_tv
                      : facility.id == 46
                          ? facility.icon = Booking_ic_recycle
                          : facility.id == 47
                              ? facility.icon = Booking_ic_wifi
                              : facility.icon = Booking_ic_coffee;
      facilitylist.add(facility);
    });
    jsonResponse['data'][3]['data'][2]['terms'].forEach((dynamic val) {
      TypeSelectedModel service =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      servicelist.add(service);
    });
    hotelFilterModel.propertylist = propertylist;
    hotelFilterModel.facilitylist = facilitylist;
    hotelFilterModel.servicelist = servicelist;
    return hotelFilterModel;
  } else {
    // ignore: unnecessary_new
    HotelFilterModel hotelFilterModel = new HotelFilterModel(
        minprice: 0,
        maxprice: 0,
        propertylist: [],
        facilitylist: [],
        servicelist: []);
    return hotelFilterModel;
  }
}

Future<BookingHotelModel> getHotelDetail(String id) async {
  var url = Uri.parse(baseUrl + '/hotel/detail/' + id);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var hoteldata = jsonResponse['data'];

    List<TypeSelectedModel> facilitylist = [];
    List<BookingFeeModel> extra_price = [], booking_fee = [];
    List<String> gallery = [];
    hoteldata['terms']['6']['child'].forEach((dynamic val) {
      TypeSelectedModel facility =
          // ignore: unnecessary_new
          new TypeSelectedModel(type: val['name'], id: val['id']);
      facility.id == 42
          ? facility.icon = Booking_ic_wakeupcall
          : facility.id == 43
              ? facility.icon = Booking_ic_car
              : facility.id == 44
                  ? facility.icon = Booking_ic_bike
                  : facility.id == 45
                      ? facility.icon = Booking_ic_tv
                      : facility.id == 46
                          ? facility.icon = Booking_ic_recycle
                          : facility.id == 47
                              ? facility.icon = Booking_ic_wifi
                              : facility.icon = Booking_ic_coffee;
      facilitylist.add(facility);
    });
    hoteldata['gallery'].forEach((dynamic val) {
      String gal = val;
      gallery.add(gal);
    });
    String? gpolicy, cpolicy, capolicy, lcopolicy;
    hoteldata['policy'].forEach((dynamic val) {
      val['title'] == 'Guarantee Policy'
          ? gpolicy = val['content']
          : val['title'] == 'Children Policy'
              ? cpolicy = val['content']
              : val['title'] == 'Cancellation/Amendment Policy'
                  ? capolicy = val['content']
                  : lcopolicy = val['content'];
    });

    hoteldata['extra_price'].forEach((dynamic val) {
      val['desc'] = "";
      BookingFeeModel bookingFeeModel = BookingFeeModel.fromJson(val);
      extra_price.add(bookingFeeModel);
    });
    hoteldata['booking_fee'].forEach((dynamic val) {
      BookingFeeModel bookingFeeModel = BookingFeeModel.fromJson(val);
      booking_fee.add(bookingFeeModel);
    });
    // ignore: unnecessary_new
    BookingHotelModel bookingHotelModel = new BookingHotelModel(
        id: hoteldata['id'],
        rating: double.parse(hoteldata['review_score']['score_total']),
        name: hoteldata['title'],
        reviewer: hoteldata['review_score']['total_review'],
        reviewstatus: hoteldata['review_score']['score_text'],
        image: hoteldata['image'],
        location: hoteldata['location']['name'],
        price: double.parse(hoteldata['price']),
        content: '<h4>Description</h4>' + hoteldata['content'],
        facilitylist: facilitylist,
        gallaries: gallery,
        video: hoteldata['video'],
        gpolicy: gpolicy,
        cpolicy: cpolicy,
        capolicy: capolicy,
        extra_price: extra_price,
        booking_fee: booking_fee,
        lcopolicy: lcopolicy);
    return bookingHotelModel;
  } else {
    // ignore: unnecessary_new
    BookingHotelModel bookingHotelModel = new BookingHotelModel(
        id: 0,
        rating: 0.0,
        name: '',
        reviewer: 0,
        reviewstatus: '',
        image: '',
        location: '',
        price: 0.0);
    return bookingHotelModel;
  }
}

Future<List<HotelRoomModel>> checkHotelAvaliable(
    String id, String params) async {
  print(baseUrl + '/hotel/availability/' + id + params);
  var url = Uri.parse(baseUrl + '/hotel/availability/' + id + params);
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var hotelrooms = jsonResponse['rooms'];
    List<HotelRoomModel> hotelRoomModelList = [];
    hotelrooms.forEach((dynamic hoteldata) {
      List<TypeSelectedModel> facilitylist = [];
      hoteldata['price'] = double.parse(hoteldata['price'].toString());
      List<String> pricelist = [];
      for (var i = 0; i < hoteldata['number']; i++) {
        i == 0
            ? pricelist.add(
                '1 Room (\$' + (hoteldata['price'] * (i + 1)).toString() + ")")
            : pricelist.add((i + 1).toString() +
                ' Rooms (\$' +
                (hoteldata['price'] * (i + 1)).toString() +
                ")");
      }
      hoteldata['term_features'].forEach((dynamic val) {
        TypeSelectedModel facility =
            // ignore: unnecessary_new
            new TypeSelectedModel(
          type: val['title'],
        );
        facility.type == 'Laundry and dry cleaning'
            ? facility.icon = Booking_ic_recycle
            : facility.type == 'Internet – Wifi'
                ? facility.icon = Booking_ic_wifi
                : facility.icon = Booking_ic_coffee;
        facilitylist.add(facility);
      });
      hoteldata['facility'] = facilitylist;
      hoteldata['price_list'] = pricelist;
      HotelRoomModel hotelRoomModel = HotelRoomModel.fromJson(hoteldata);
      hotelRoomModelList.add(hotelRoomModel);
    });
    return hotelRoomModelList;
  } else {
    return [];
  }
}

Future<bool> addToCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var bearToken = 'Bearer ' + (prefs.getString('access_token') ?? "");
  var url = Uri.parse(baseUrl + '/booking/addToCart');
  var body = convert.jsonEncode({
    "service_id": 9,
    "service_type": "hotel",
    "start_date": "2022-07-08",
    "end_date": "2022-07-09",
    "extra_price": [
      {
        "name": "Service VIP ",
        "price": "200",
        "type": "one_time",
        "number": 0,
        "enable": true,
        "price_html": "\$200",
        "price_type": ""
      },
      {
        "name": "Breakfasts",
        "price": "100",
        "type": "one_time",
        "number": 1,
        "enable": 1,
        "price_html": "\$100",
        "price_type": ""
      }
    ],
    "adults": 1,
    "children": 0,
    "rooms": [
      {"id": 33, "number_selected": 1},
      {"id": 34, "number_selected": 0},
      {"id": 35, "number_selected": 0},
      {"id": 36, "number_selected": 0}
    ]
  });
  var response = await http.post(url,
      headers: {"Content-Type": "application/json", "Authorization": bearToken},
      body: body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse.toString());

    return true;
  } else {
    return false;
  }
}
