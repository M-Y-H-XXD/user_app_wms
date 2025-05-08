import 'package:flutter/material.dart';
import 'package:wms/constants_components/enter_way.dart';
import 'package:wms/static_classes/user_informations.dart';

RegExp regExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.enterType});
  final Enum enterType;

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
        if (enterType == EnterWay.sinUp) {
          if (value == null || value.isEmpty) {
            return 'field is required';
          }
          if (!regExp.hasMatch(value)) {
            return 'email is invalid';
          }
        } else if (enterType == EnterWay.logIn) {
          if (UserInformations.phoneNumber == null ||
              UserInformations.phoneNumber!.isEmpty) {
            if (value == null || value.isEmpty) {
              return 'email or phone required';
            }
            if (!regExp.hasMatch(value)) {
              return 'email is invalid';
            }
          } else if (UserInformations.phoneNumber != null &&
              (value != null && value.isNotEmpty)) {
            {
              if (!regExp.hasMatch(value)) {
                return 'email is invalid';
              }
            }
          }
        }
        return null;
      },
      onSaved: (value) {
        UserInformations.email = value;
      },
    );
  }
}
