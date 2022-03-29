import 'package:bookingapp/models/BookingCommonModel.dart';
import 'package:bookingapp/models/CarModel.dart';
import 'package:bookingapp/models/DestinationModel.dart';
import 'package:bookingapp/models/HomePageModel.dart';
import 'package:bookingapp/models/TourModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<HomePageModel> getHomeData() async {
  var url = Uri.parse('http://dev.bookingcore.org/api/home-page');
  var response =
      await http.get(url, headers: {"Content-Type": "application/json"});

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<BookingHotelModel> hotelmodelList = [];
    List<DestinationModel> distmodelList = [];
    List<CarModel> carmodelList = [];
    List<TourModel> tourList = [];
    HomePageModel homePageModel =
        // ignore: unnecessary_new
        new HomePageModel(
            hotellist: [],
            title: '',
            subtitle: '',
            htitle: '',
            hsubtitle: '',
            distlist: [],
            dtitle: '',
            dsubtitle: '',
            carlist: [],
            ctitle: '',
            csubtitle: '',
            tourlist: [],
            ttitle: '',
            tsubtitle: '');
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
      );
      hotelmodelList.add(bookingHotelModel);
    });
    jsonResponse['data'][3]['model']['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      DestinationModel distinationModel = new DestinationModel(
          id: val['id'],
          title: val['title'],
          image: val['image'],
          content: val['content'] ?? '');
      distmodelList.add(distinationModel);
    });
    jsonResponse['data'][4]['model']['data'].forEach((dynamic val) {
      // ignore: unnecessary_new
      TourModel tourModel = new TourModel(
          id: val['id'],
          rating: double.parse(val['review_score']['score_total']),
          title: val['title'],
          reviewer: val['review_score']['total_review'],
          image: val['image'],
          location: val['location']['name'],
          price: double.parse(val['price']),
          saleprice: double.parse(val['sale_price']),
          content: val['content']);
      tourList.add(tourModel);
    });
    jsonResponse['data'][6]['model']['data'].forEach((dynamic val) {
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
    homePageModel.title = jsonResponse['data'][0]['model']['title'];
    homePageModel.subtitle = jsonResponse['data'][0]['model']['sub_title'];
    homePageModel.htitle = jsonResponse['data'][2]['model']['title'];
    homePageModel.hsubtitle = jsonResponse['data'][2]['model']['desc'];
    homePageModel.hotellist = hotelmodelList;
    homePageModel.distlist = distmodelList;
    homePageModel.dtitle = jsonResponse['data'][3]['model']['title'];
    homePageModel.dsubtitle = jsonResponse['data'][3]['model']['desc'];
    homePageModel.tourlist = tourList;
    homePageModel.ttitle = jsonResponse['data'][4]['model']['title'];
    homePageModel.tsubtitle = jsonResponse['data'][4]['model']['desc'];
    homePageModel.carlist = carmodelList;
    homePageModel.ctitle = jsonResponse['data'][6]['model']['title'];
    homePageModel.csubtitle = jsonResponse['data'][6]['model']['desc'];
    return homePageModel;
  } else {
    HomePageModel homePageModel =
        // ignore: unnecessary_new
        new HomePageModel(
            hotellist: [],
            title: '',
            subtitle: '',
            htitle: '',
            hsubtitle: '',
            distlist: [],
            dtitle: '',
            dsubtitle: '',
            carlist: [],
            ctitle: '',
            csubtitle: '',
            tourlist: [],
            ttitle: '',
            tsubtitle: '');
    return homePageModel;
  }
}
