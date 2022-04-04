// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingSignInScreen extends StatefulWidget {
  @override
  BookingSignInScreenState createState() => BookingSignInScreenState();
}

class BookingSignInScreenState extends State<BookingSignInScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isSignUp = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController cPassCont = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController aboutyourself = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height(),
        color: context.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                30.height,
                commonCacheImageWidget(BookingLogo, 80, fit: BoxFit.cover)
                    .center(),
                30.height,
                Container(
                  decoration: boxDecorationRoundedWithShadow(8,
                      backgroundColor: context.cardColor),
                  width: context.width(),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            color:
                                isSignUp ? Booking_AppBar : Booking_Secondary,
                            padding: EdgeInsets.only(
                                left: 20, right: 16, top: 8, bottom: 8),
                            child: Text('Sign In',
                                style: boldTextStyle(
                                    color: !isSignUp ? white : black)),
                          )
                              .cornerRadiusWithClipRRectOnly(
                                  topLeft: 30, bottomLeft: 30)
                              .onTap(() {
                            isSignUp = false;
                            setState(() {});
                          }),
                          Container(
                            alignment: Alignment.center,
                            color:
                                isSignUp ? Booking_Secondary : Booking_AppBar,
                            padding: EdgeInsets.only(
                                left: 16, right: 20, top: 8, bottom: 8),
                            child: Text('Sign Up',
                                style: boldTextStyle(
                                    color: isSignUp ? white : black)),
                          )
                              .cornerRadiusWithClipRRectOnly(
                                  topRight: 30, bottomRight: 30)
                              .onTap(() {
                            isSignUp = true;
                            setState(() {});
                          }),
                        ],
                      ),
                      20.height,
                      Text(
                          isSignUp
                              ? 'Please enter your information below.'
                              : 'Please login to your account',
                          style: boldTextStyle()),
                      20.height,
                      buildEmailField(),
                      20.height.visible(isSignUp),
                      buildFirstNameField().visible(isSignUp),
                      20.height.visible(isSignUp),
                      buildLastNameField().visible(isSignUp),
                      20.height,
                      buildPasswordField(),
                      20.height,
                      buildConfirmPasswordField().visible(isSignUp),
                      20.height,
                      buildPhoneNumberField().visible(isSignUp),
                      20.height,
                    ],
                  ),
                ),
                16.height,
                Container(
                  height: 50,
                  width: 130,
                  decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: Booking_Secondary,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.arrow_right_alt, color: white, size: 40),
                ).onTap(() {
                  if (!isSignUp) {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  } else {
                    isSignUp = !isSignUp;
                    setState(() {});
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      controller: phoneNumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Phone Number',
          suffixIcon: Icon(Booking_ic_phone),
          suffixIconColor: Booking_InputBorder),
    );
  }

  AppTextField buildConfirmPasswordField() {
    return AppTextField(
      controller: cPassCont,
      textFieldType: TextFieldType.PASSWORD,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Confirm Password', suffixIconColor: Booking_InputBorder),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passCont,
      keyboardType: TextInputType.visiblePassword,
       validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Password', suffixIconColor: Booking_InputBorder),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: emailCont,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Email Id',
        suffixIcon: Icon(Booking_ic_email),
      ),
    );
  }

  TextFormField buildLastNameField() {
    return TextFormField(
      controller: lastName,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Last Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      controller: firstName,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'First Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }
}
