// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:bookingapp/main.dart';
import 'package:bookingapp/services/user.service.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingSignInScreen extends StatefulWidget {
  String? localeCheck;
  BookingSignInScreen({Key? key, this.localeCheck}) : super(key: key);
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
                              : widget.localeCheck != null &&
                                      widget.localeCheck == "MM"
                                  ? 'သင့်အကောင့်သို့ ဝင်ရောက်ပါ'
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
                ).onTap(() async {
                  if (!isSignUp) {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      bool loginSuccess =
                          await userLogin(emailCont.text, passCont.text);
                      if (loginSuccess) {
                        Checkscreen(checktoken: true, localeCheck: localeCheck)
                            .launch(context,
                                pageRouteAnimation:
                                    PageRouteAnimation.SlideBottomTop);
                      }
                    }
                  } else {
                    isSignUp = !isSignUp;
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      bool registerSuccess = await userRegister(
                          emailCont.text,
                          passCont.text,
                          firstName.text,
                          lastName.text,
                          phoneNumber.text);
                      if (registerSuccess) {
                        Checkscreen(checktoken: true, localeCheck: localeCheck)
                            .launch(context,
                                pageRouteAnimation:
                                    PageRouteAnimation.SlideBottomTop);
                      }
                    }
                    // setState(() {});
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppTextField buildPhoneNumberField() {
    return AppTextField(
      controller: phoneNumber,
      textFieldType: TextFieldType.PHONE,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_phone;
        }
        return null;
      },
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
          return Booking_err_txt_cpwd;
        } else if (cPassCont.value != passCont.value) {
          return Booking_err_txt_pwd_match;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Confirm Password', suffixIconColor: Booking_InputBorder),
    );
  }

  AppTextField buildPasswordField() {
    return AppTextField(
      controller: passCont,
      textFieldType: TextFieldType.PASSWORD,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_pwd;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: 'Password', suffixIconColor: Booking_InputBorder),
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

  AppTextField buildLastNameField() {
    return AppTextField(
      controller: lastName,
      textFieldType: TextFieldType.NAME,
      decoration: InputDecoration(
        hintText: 'Last Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_phone;
        }
        return null;
      },
    );
  }

  AppTextField buildFirstNameField() {
    return AppTextField(
      controller: firstName,
      textFieldType: TextFieldType.NAME,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return Booking_err_txt_name1;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'First Name',
        suffixIcon: Icon(Booking_ic_person),
      ),
    );
  }
}
