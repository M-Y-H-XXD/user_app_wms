import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

RegExp regExp = RegExp(r'^\d{9,15}$');

class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),

        labelText: 'Phone Number',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      cursorColor: Colors.black,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field is required';
        }
        if (!regExp.hasMatch(value)) {
          return 'phone number is invalid';
        }
        return null;
      },
      onSaved: (value) {
        UserInformations.phoneNumber = value;
      },
    );
  }
}
