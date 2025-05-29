import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

class SetPasswordField extends StatefulWidget {
  const SetPasswordField({super.key});

  @override
  State<SetPasswordField> createState() => _SetPasswordFieldState();
}

class _SetPasswordFieldState extends State<SetPasswordField> {
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

        labelText: 'set password',
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
        if (value != UserInformations.password) {
          return 'password not identical';
        }
        return null;
      },
    );
  }
}
