// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/main.dart';
import 'package:bookingapp/services/hotel.page.service.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
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
  List<String>? choiceRoom;
  String? bookingCode;
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
      this.bookingCode})
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
        )),
      ),
    );
  }
}

class BookingInfo extends StatefulWidget {
  String? startDate, endDate, adults, child;
  double? totalPrice;
  List<String>? choiceRoom;
  String? bookingCode;
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
      this.bookingCode})
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
              children: [Text("Start Date"), Text(widget.startDate ?? "")],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("End Date"), Text(widget.startDate ?? "")],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Adult "), Text(widget.startDate ?? "")],
            ),
            16.height,
            SizedBox(
              child: ListView.builder(
                itemCount: widget.choiceRoom?.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.choiceRoom?[index] ?? ""),
                      Text("\$500")
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
                Text(widget.totalPrice?.toString() ?? "")
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
                    await checkOut(
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
                        _character == 1 ? "offline_payment" : "ngenius_payment",
                        widget.bookingCode ?? "");
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var bearToken = prefs.getString('access_token');

                    Checkscreen(
                      checktoken: bearToken != null,
                    ).launch(context,
                        pageRouteAnimation: PageRouteAnimation.SlideBottomTop);
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
