// ignore_for_file: prefer_const_constructors

import 'package:bookingapp/models/UserModel.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookinUserLocationComponent extends StatelessWidget {
  final UserModel userModel;
  BookinUserLocationComponent({Key? key, required this.userModel})
      : super(key: key);

  TextEditingController addressCont1 = TextEditingController();

  TextEditingController addressCont2 = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController stateCont = TextEditingController();
  TextEditingController countryCont = TextEditingController();
  TextEditingController zipCodeCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    addressCont1.text = userModel.address;
    addressCont2.text = userModel.address2;
    cityCont.text = userModel.city;
    stateCont.text = userModel.state;
    zipCodeCont.text = userModel.zipcode;
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                buildAddress1Field(),
                16.height,
                buildAddress2Field(),
                16.height,
                buildCityField(),
                16.height,
                buildStateField(),
                16.height,
                buildZipCodeField(),
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
                      }
                    },
                    height: 50,
                    width: context.width(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  AppTextField buildAddress1Field() {
    return AppTextField(
      controller: addressCont1,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_address1,
        suffixIcon: Icon(Booking_ic_address),
      ),
    );
  }

  AppTextField buildAddress2Field() {
    return AppTextField(
      controller: addressCont1,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_address2,
        suffixIcon: Icon(Booking_ic_address),
      ),
    );
  }

  AppTextField buildCityField() {
    return AppTextField(
      controller: cityCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_city,
        suffixIcon: Icon(Booking_ic_city),
      ),
    );
  }

  AppTextField buildStateField() {
    return AppTextField(
      controller: countryCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_state,
        suffixIcon: Icon(Booking_ic_state),
      ),
    );
  }

  AppTextField buildZipCodeField() {
    return AppTextField(
      controller: countryCont,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        hintText: Booking_placeh_zipCode,
        suffixIcon: Icon(Booking_ic_zipcode),
      ),
    );
  }
}
