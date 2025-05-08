import 'package:flutter/material.dart';
import 'package:wms/static_classes/user_informations.dart';

RegExp regExp = RegExp(
  r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01]) (?:[01]\d|2[0-3]):[0-5]\d:[0-5]\d\.\d{3}$',
);

class BirthDayField extends StatefulWidget {
  const BirthDayField({super.key, this.label});
  final String? label;

  @override
  State<BirthDayField> createState() => _BirthDayFieldState();
}

class _BirthDayFieldState extends State<BirthDayField> {
  DateTime? dateTime;
  DateTime? newDate;
  @override
  void initState() {
    dateTime = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),

        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.black, fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: '${dateTime!.day}/${dateTime!.month}/${dateTime!.year}',
      ),
      cursorColor: Colors.black,
      validator: (value) {
        if (newDate == null) {
          return 'field is required';
        }
        return null;
      },

      onTap: () async {
        newDate = await showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          initialEntryMode: DatePickerEntryMode.calendarOnly,
        );
        if (newDate != null) {
          setState(() {
            dateTime = newDate;
          });
        }
      },
      onSaved: (value) {
        if (newDate != null) {
          UserInformations.birthDay = dateTime;
        }
      },
    );
  }
}
