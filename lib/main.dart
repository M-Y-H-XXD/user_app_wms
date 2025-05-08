import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wms/generated/l10n.dart';
import 'package:wms/modles/constant_colors.dart';
// import 'package:wms/mywigets/my_home_page.dart';

import 'package:wms/providers/language_provider.dart';
import 'package:wms/providers/theme_mode_provider.dart';
import 'package:wms/screens/register.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale:
          (context.watch<LanguageProvider>().language == 'ar')
              ? const Locale('ar')
              : const Locale('en'),
      theme: ThemeData(
        fontFamily: 'CascadiaMono',
        primaryColor: Colors.white70,
        primaryColorDark: Colors.white,
        primaryColorLight: Colors.black,
        //cardColor: Colors.white,
        // listTileTheme: ListTileThemeData(
        //   tileColor: Colors.white,
        // ),
        appBarTheme: const AppBarTheme(color: ConstantColors.appBarColorLight),
        scaffoldBackgroundColor: ConstantColors.ScaffoldBackgroundColorLight,
      ),

      darkTheme: //ThemeData.dark()
          ThemeData(
        fontFamily: 'CascadiaMono',

        primaryColor: Colors.blueGrey,
        primaryColorDark: ConstantColors.DrawerBackgroundColorDark,
        primaryColorLight: Colors.white,
        //cardColor: Colors.black,
        // listTileTheme: ListTileThemeData(
        //   tileColor: Colors.black,
        // ),
        appBarTheme: const AppBarTheme(color: ConstantColors.appBarColorDark),
        scaffoldBackgroundColor: ConstantColors.ScaffoldBackgroundColorDark,
      ),
      themeMode:
          (context.watch<ThemeModeProvider>().isDark == true)
              ? ThemeMode.dark
              : ThemeMode.light,
      home: const Register(),
      //const MyHomePage(),
    );
  }
}
