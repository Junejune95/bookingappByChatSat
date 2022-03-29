import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/CommonModel.dart';
import 'package:bookingapp/models/HotelFilterModel.dart';
import 'package:bookingapp/utils/BookingIcons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<BookingHotelModel>> getHotelData(String params) async {
  var url = Uri.parse('http://dev.bookingcore.org/api/hotel/search?' + params);
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
  var url = Uri.parse('http://dev.bookingcore.org/api/hotel/filters');
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
