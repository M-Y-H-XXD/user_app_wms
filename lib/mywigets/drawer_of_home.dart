import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/providers/language_provider.dart';
import 'package:wms/providers/theme_mode_provider.dart';
import 'package:wms/screens/choose_language.dart';
import 'package:wms/screens/register.dart';

class DrawerOfHome extends StatefulWidget {
  const DrawerOfHome({super.key});

  @override
  State<DrawerOfHome> createState() => _DrawerOfHomeState();
}

class _DrawerOfHomeState extends State<DrawerOfHome> {
  late bool isDark;
  late String language;

  Future<bool?> _getValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'images/personal photo.jpg',
                        fit: BoxFit.cover,
                        height: size.height / 7,
                        width: size.height / 7,
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  IconButton(
                    onPressed: () async {
                      bool? valDark = await _getValue('isDark');
                      valDark == true ? isDark = true : isDark = false;

                      isDark = !isDark;

                      var providerThemeMode = context.read<ThemeModeProvider>();
                      providerThemeMode.changeThemeMode(newIsDark: isDark);
                    },
                    icon: Icon(
                      Icons.sunny,
                      size: size.height / 18,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      S.of(context).language,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    tileColor: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseLanguage(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app_outlined,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      S.of(context).sign_out,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    tileColor: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                        (route) => false,
                      );
                      var providerThemeMode = context.read<ThemeModeProvider>();
                      providerThemeMode.changeThemeMode(newIsDark: false);
                      var providerLanguage = context.read<LanguageProvider>();
                      providerLanguage.changeLanguage(newLanguage: 'en');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
