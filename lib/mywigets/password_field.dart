import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),

        labelText: 'password',
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            isObscure = !isObscure;
            setState(() {});
          },
          icon: Icon(
            (isObscure)
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
        ),
      ),
      cursorColor: Colors.black,

      obscureText: isObscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'field is required';
        }
        if (value.length < 8) {
          return 'password is too short';
        }
        return null;
      },
      onSaved: (value) {
        UserInformations.password = value;
      },
    );
  }
}
