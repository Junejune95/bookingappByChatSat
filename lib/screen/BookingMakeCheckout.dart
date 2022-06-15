// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/main.dart';
import 'package:bookingapp/models/FightModel.dart';
import 'package:bookingapp/screen/BookingPaymentWebView.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingConstants.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingMakeCheckout extends StatelessWidget {
  String? startDate, endDate, adults, child;
  String firstName,
      lastName,
      email,
      phone,
      address1,
      address2,
      city,
      state,
      country,
      note;
  double? totalPrice;
  List<String?>? choiceRoom;
  String? bookingCode;
  String? title;
  int? number;
  FlightModel? flight;
  List<FlighSeattModel?>? seats;
  BookingMakeCheckout(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.country,
      required this.note,
      this.startDate,
      this.endDate,
      this.adults,
      this.child,
      this.totalPrice,
      this.choiceRoom,
      this.bookingCode,
      this.title,
      this.number,
      this.flight,
      this.seats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Booking Check Out'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: BookingInfo(
          firstName: firstName,
          lastName: lastName,
          email: email,
          city: city,
          state: state,
          country: country,
          address1: address1,
          address2: address2,
          note: note,
          phone: phone,
          startDate: startDate,
          endDate: endDate,
          totalPrice: totalPrice,
          choiceRoom: choiceRoom,
          adults: adults,
          child: child,
          bookingCode: bookingCode,
          title: title,
          number: number,
          flight: flight,
          seats: seats,
        )),
      ),
    );
  }
}

class BookingInfo extends StatefulWidget {
  String? startDate, endDate, adults, child;
  double? totalPrice;
  List<String?>? choiceRoom;
  String? bookingCode;
  String? title;
  int? number;
  FlightModel? flight;
  List<FlighSeattModel?>? seats;
  String firstName,
      lastName,
      email,
      phone,
      address1,
      address2,
      city,
      state,
      country,
      note;
  BookingInfo(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address1,
      required this.address2,
      required this.city,
      required this.state,
      required this.country,
      required this.note,
      this.startDate,
      this.endDate,
      this.adults,
      this.child,
      this.totalPrice,
      this.choiceRoom,
      this.bookingCode,
      this.title,
      this.number,
      this.flight,
      this.seats})
      : super(key: key);

  @override
  State<BookingInfo> createState() => _BookingInfoState();
}

class _BookingInfoState extends State<BookingInfo> {
  final _formKey = GlobalKey<FormState>();
  int? _character = 1;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(""), Text(widget.title ?? ''), Text("")],
            ),
            if (widget.flight != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Booking_ic_takeof,
                    size: 30,
                    color: Booking_Secondary,
                  ),
                  20.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      titleText(
                          title: widget.flight!.departuretime.isNotEmpty
                              ? DateFormat("hh:mm").format(
                                  DateTime.parse(widget.flight!.departuretime))
                              : "",
                          size: textSizeLargeMedium.toInt()),
                      14.height,
                      Text(
                        widget.flight!.departuretime.isNotEmpty
                            ? DateFormat('EEE, MMM d yy').format(
                                DateTime.parse(widget.flight!.departuretime))
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Booking_TextColorSecondary,
                            fontSize: textSizeMedium),
                      ),
                      14.height,
                      Text(
                        widget.flight!.location_from,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Booking_TextColorSecondary,
                            fontSize: textSizeMedium),
                      ),
                    ],
                  ),
                ],
              ),
            if (widget.startDate != null && widget.startDate != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Start Date"), Text(widget.startDate ?? "")],
              ),
            16.height,
            if (widget.flight != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Booking_ic_landing,
                    size: 30,
                    color: Booking_Secondary,
                  ),
                  20.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      titleText(
                          title: widget.flight!.arrivaltime.isNotEmpty
                              ? DateFormat("hh:mm").format(
                                  DateTime.parse(widget.flight!.arrivaltime))
                              : "",
                          size: textSizeLargeMedium.toInt()),
                      14.height,
                      Text(
                        widget.flight!.arrivaltime.isNotEmpty
                            ? DateFormat('EEE, MMM d yy').format(
                                DateTime.parse(widget.flight!.arrivaltime))
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Booking_TextColorSecondary,
                            fontSize: textSizeMedium),
                      ),
                      14.height,
                      Text(
                        widget.flight!.location_to,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Booking_TextColorSecondary,
                            fontSize: textSizeMedium),
                      ),
                    ],
                  ),
                ],
              ),
            if (widget.endDate != null && widget.endDate != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("End Date"), Text(widget.endDate ?? "")],
              ),
            16.height,
            if (widget.adults != null && widget.adults != '0')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Adult "), Text(widget.adults ?? "")],
              ),
            if (widget.number != null && widget.number != '0')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Number "), Text(widget.number!.toString())],
              ),
            16.height,
            SizedBox(
              child: ListView.builder(
                itemCount: widget.choiceRoom?.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.choiceRoom?[index] != null)
                        Text(widget.choiceRoom?[index] ?? ""),
                      if (widget.choiceRoom?[index] != null) Text("\$500")
                    ],
                  );
                },
              ),
              height: 70,
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price"),
                Text("\$" + (widget.totalPrice?.toString() ?? ""))
              ],
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Offline Payment'),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: _character,
                    onChanged: (int? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Ngenius Payment'),
                  leading: Radio<int>(
                    value: 2,
                    groupValue: _character,
                    onChanged: (int? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            30.height,
            Center(
              child: defaultButton(
                text: Booking_lbl_BookNow,
                tap: () async {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );

                    dynamic response = await checkOut(
                        widget.firstName,
                        widget.lastName,
                        widget.email,
                        widget.phone,
                        widget.city,
                        widget.state,
                        widget.country,
                        widget.address1,
                        widget.address2,
                        widget.note,
                        _character == 1 ? "offline_payment" : "ngenius",
                        widget.bookingCode ?? "");
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var bearToken = prefs.getString('access_token');
                    if (response != null && response['url'] != "") {
                      BookingPaymentScreen(
                        url: response['url'],
                      ).launch(context,
                          pageRouteAnimation:
                              PageRouteAnimation.SlideBottomTop);
                    } else {
                      Checkscreen(
                        checktoken: bearToken != null,
                      ).launch(context,
                          pageRouteAnimation:
                              PageRouteAnimation.SlideBottomTop);
                    }
                  }
                },
                height: 50,
                width: context.width(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
