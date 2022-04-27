// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/screen/BookingMakeCheckout.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingCheckoutScreen extends StatelessWidget {
  String? startDate, endDate, adults, child;
  double? totalPrice;
  List<String>? choiceRoom;
  String? bookingCode;
  BookingCheckoutScreen(
      {Key? key,
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
            child: BookingUserDataInfo(
                startDate: startDate,
                endDate: endDate,
                totalPrice: totalPrice,
                choiceRoom: choiceRoom,
                adults: adults,
                child: child,
                bookingCode: bookingCode)),
      ),
    );
  }
}

class BookingUserDataInfo extends StatefulWidget {
  String? startDate, endDate, adults, child;
  double? totalPrice;
  List<String>? choiceRoom;
  String? bookingCode;
  BookingUserDataInfo(
      {Key? key,
      this.startDate,
      this.endDate,
      this.adults,
      this.child,
      this.totalPrice,
      this.choiceRoom,
      this.bookingCode})
      : super(key: key);

  @override
  State<BookingUserDataInfo> createState() => _BookingUserDataInfoState();
}

class _BookingUserDataInfoState extends State<BookingUserDataInfo> {
  TextEditingController nameCont = TextEditingController();

  TextEditingController emailCont = TextEditingController();

  TextEditingController firstNameCont = TextEditingController();

  TextEditingController lastNameCont = TextEditingController();

  TextEditingController phoneCont = TextEditingController();

  TextEditingController address1 = TextEditingController();

  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController notes = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            buildEmailField(),
            16.height,
            buildFirstNameField(),
            16.height,
            buildLastNameField(),
            16.height,
            buildPhoneNumberField(),
            16.height,
            buildAdd1(),
            16.height,
            buildAdd2(),
            16.height,
            buildCity(),
            16.height,
            buildState(),
            16.height,
            buildCountry(),
            16.height,
            buildRequirement(),
            30.height,
            Center(
              child: defaultButton(
                text: Booking_lbl_btn_Save,
                tap: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    BookingMakeCheckout(
                            firstName: firstNameCont.text,
                            lastName: lastNameCont.text,
                            email: emailCont.text,
                            city: city.text,
                            state: state.text,
                            country: country.text,
                            address1: address1.text,
                            address2: address2.text,
                            note: notes.text,
                            phone: phoneCont.text,
                            startDate: widget.startDate,
                            endDate: widget.endDate,
                            totalPrice: widget.totalPrice,
                            choiceRoom: widget.choiceRoom,
                            adults: widget.adults,
                            child: widget.child,
                            bookingCode: widget.bookingCode)
                        .launch(context,
                            pageRouteAnimation:
                                PageRouteAnimation.SlideBottomTop);
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

  AppTextField buildNameField() {
    return AppTextField(
      controller: nameCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_name1;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_name,
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  AppTextField buildFirstNameField() {
    return AppTextField(
      controller: firstNameCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_name1;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_firstName,
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  AppTextField buildLastNameField() {
    return AppTextField(
      controller: lastNameCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_name2;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_lastName,
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  AppTextField buildPhoneNumberField() {
    return AppTextField(
      controller: phoneCont,
      textFieldType: TextFieldType.PHONE,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          hintText: Booking_placeh_phoneNum,
          suffixIcon: Icon(Booking_ic_phone),
          suffixIconColor: Booking_InputBorder),
    );
  }

  AppTextField buildEmailField() {
    return AppTextField(
      controller: emailCont,
      textFieldType: TextFieldType.EMAIL,
      decoration: InputDecoration(
        hintText: Booking_placeh_email,
        suffixIcon: Icon(Booking_ic_email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          return Booking_err_txt_email_invalid;
        }
        return null;
      },
    );
  }

  AppTextField buildAdd1() {
    return AppTextField(
      controller: address1,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "Your address Line 1",
        suffixIcon: Icon(Booking_ic_address),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        }
        return null;
      },
    );
  }

  AppTextField buildAdd2() {
    return AppTextField(
      controller: address2,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "Your address Line 2",
        suffixIcon: Icon(Booking_ic_address),
      ),
      validator: (value) {
        return null;
      },
    );
  }

  AppTextField buildCity() {
    return AppTextField(
      controller: city,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "Your City",
        suffixIcon: Icon(Booking_ic_city),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        }
        return null;
      },
    );
  }

  AppTextField buildState() {
    return AppTextField(
      controller: state,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "State/Region",
        suffixIcon: Icon(Booking_ic_state),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        }
        return null;
      },
    );
  }

  AppTextField buildCountry() {
    return AppTextField(
      controller: country,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "Your Country",
        suffixIcon: Icon(Booking_ic_city),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        }
        return null;
      },
    );
  }

  AppTextField buildRequirement() {
    return AppTextField(
      controller: notes,
      textFieldType: TextFieldType.OTHER,
      decoration: InputDecoration(
        hintText: "Speacial Requirements",
        suffixIcon: Icon(Booking_ic_note),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_email;
        }
        return null;
      },
    );
  }

  AppTextField builCountry() {
    return AppTextField(
      controller: country,
      textFieldType: TextFieldType.NAME,
      minLines: 4,
      maxLines: 4,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_note,
      ),
    );
  }
}
