import 'package:bookingapp/constants.dart';
import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/models/HotelFilterModel.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
