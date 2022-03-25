import 'package:bookingapp/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF000000);
const kPrimaryLightColor = Color(0xFF969494);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFFA53E),
    Color(0xFFFF7643),
  ],
);
const kSecondaryColor = Color(0xFFdd4b4a);
const kSecondaryLightColor = Color(0xFFF8E5E5);
const kTextColor = Color(0xFF000000);
const kTextLightColor = Color(0xFF525252);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kNameNullError = "Please Enter your name";
const String kPhoneNullError = "Please Enter your phone";
const String kDOBNullError = "Please Enter your DOB";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kNewPassNullError = "Please Enter your new password";
const String kOldPassNullError = "Please Enter your current password";
const String kConfirmPassNullError = "Please Enter your confirm password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineFocusBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return const OutlineInputBorder(
    // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

OutlineInputBorder outlineFocusBorder() {
  return const OutlineInputBorder(
    // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kSecondaryColor),
  );
}
