// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/services/home.page.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingEnquiryForm extends StatelessWidget {
  final String type;
  final int id;
  BookingEnquiryForm({Key? key, required this.type, required this.id})
      : super(key: key);

  TextEditingController nameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        color: context.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildNameField(),
                16.height,
                buildEmailField(),
                16.height,
                buildPhoneNumberField(),
                16.height,
                buildNoteField(),
                16.height,
                Center(
                  child: defaultButton(
                    text: Booking_lbl_SendNow,
                    tap: () async {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        bool res = await enquiry(
                            type,
                            nameCont.text,
                            emailCont.text,
                            phoneCont.text,
                            noteCont.text,
                            id.toString());
                        res
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Thank you for contacting us! We will be in contact shortly.')),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Something went wrong.')),
                              );
                      }
                    },
                    height: 50,
                    width: 180,
                  ),
                )
              ],
            )),
      ),
    );
  }

  AppTextField buildEmailField() {
    return AppTextField(
      controller: emailCont,
      textFieldType: TextFieldType.EMAIL,
      decoration: InputDecoration(
        hintText: 'Email Id',
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
        hintText: 'Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  AppTextField buildNoteField() {
    return AppTextField(
      controller: noteCont,
      textFieldType: TextFieldType.NAME,
      minLines: 4,
      maxLines: 4,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Note',
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
          hintText: 'Phone Number',
          suffixIcon: Icon(Booking_ic_phone),
          suffixIconColor: Booking_InputBorder),
    );
  }
}
