import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/providers/language_provider.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  String? languageGroupr;
  void changeLanguageOfTheApp({required String language}) {
    if (language != Intl.getCurrentLocale()) {
      var providerLanguage = context.read<LanguageProvider>();
      providerLanguage.changeLanguage(newLanguage: language);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = size.width / 12;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).choose_language),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              RadioListTile(
                title: Text('English', style: TextStyle(fontSize: fontSize)),
                activeColor: Colors.blue,
                value: 'en',
                groupValue: languageGroupr,
                onChanged: (val) {
                  setState(() {
                    languageGroupr = val;
                  });
                  changeLanguageOfTheApp(language: val!);
                },
              ),
              RadioListTile(
                title: Text('العربية', style: TextStyle(fontSize: fontSize)),
                activeColor: Colors.blue,
                value: 'ar',
                groupValue: languageGroupr,
                onChanged: (val) {
                  setState(() {
                    languageGroupr = val;
                  });
                  changeLanguageOfTheApp(language: val!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
