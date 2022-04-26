import 'package:bookingapp/models/UserModel.dart';
import 'package:bookingapp/utils/BookingColors.dart';
import 'package:bookingapp/utils/BookingIconsImages.dart';
import 'package:bookingapp/utils/BookingStrings.dart';
import 'package:bookingapp/utils/BookingWidgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class UserInformation extends StatefulWidget {
  final UserModel userModel;
  UserInformation({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController nameCont = TextEditingController();

  TextEditingController emailCont = TextEditingController();

  TextEditingController firstNameCont = TextEditingController();

  TextEditingController lastNameCont = TextEditingController();

  TextEditingController phoneCont = TextEditingController();

  TextEditingController aboutCont = TextEditingController();

  TextEditingController birthdayCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            buildNameField(widget.userModel.name),
            16.height,
            buildEmailField(widget.userModel.email),
            16.height,
            buildFirstNameField(widget.userModel.first_name),
            16.height,
            buildLastNameField(widget.userModel.last_name),
            16.height,
            buildPhoneNumberField(widget.userModel.phone),
            16.height,
            buildBdDateField(),
            16.height,
            builAboutField(),
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
          ]),
        ),
      ),
    );
  }

  AppTextField buildNameField(String name) {
    nameCont.text = widget.userModel.name;
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

  AppTextField buildFirstNameField(String firstName) {
    firstNameCont.text = widget.userModel.first_name;
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

  AppTextField buildLastNameField(String lastName) {
    lastNameCont.text = widget.userModel.last_name;
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

  AppTextField buildPhoneNumberField(String phone) {
    phoneCont.text = widget.userModel.phone;
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

  AppTextField buildEmailField(String email) {
    emailCont.text = email;
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

  TextField buildBdDateField() {
    return TextField(
      controller: birthdayCont, //editing controller of this TextField
      decoration: InputDecoration(
          suffixIcon: Icon(Icons.calendar_today), //icon of text field
          labelText: Booking_placeh_birthday //label text of field
          ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101));

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            birthdayCont.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },
    );
  }

  AppTextField builAboutField() {
    return AppTextField(
      controller: aboutCont,
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
