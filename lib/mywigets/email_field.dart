import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

class EmailField extends StatelessWidget {
  const EmailField({super.key});

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

        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.black, fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field is required';
        }
        if (!regExp.hasMatch(value)) {
          return 'email is invalid';
        }
        return null;
      },
      onSaved: (value) {
        UserInformations.email = value;
      },
    );
  }
}
