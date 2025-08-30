import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

RegExp lettersOnlyRegExp = RegExp(r'^[a-zA-Z\u0621-\u064A]+$');

class NameField extends StatelessWidget {
  const NameField({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),

        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field is required';
        }
        if (!lettersOnlyRegExp.hasMatch(value)) {
          return 'use just characters';
        }
        return null;
      },
      onSaved: (value) {
        (label == 'First Name')
            ? UserInformations.userName = value
            : (label == 'Last Name')
            ? UserInformations.lastName = value
            : (label == 'Location' ||
                label == 'location' ||
                label == 'الموقع') //location
            ? UserInformations.location = value
            : null;
      },
    );
  }
}
