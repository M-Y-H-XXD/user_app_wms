import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/mywigets/drawer_of_home.dart';
import 'package:wms/screens/home.dart';
import 'package:wms/screens/me.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> listWidget = [const Home(), const Me()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerOfHome(),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: ConstantColors.CurvedNavigationBarBackground,
        color: ConstantColors.CurvedNavigationBarColor,
        items: <Widget>[
          Icon(
            Icons.home,
            size: size.width / 12,
            color: Theme.of(context).primaryColor,
          ),
          Icon(
            Icons.list,
            size: size.width / 12,
            color: Theme.of(context).primaryColor,
          ),
          // Icon(Icons.compare_arrows,size: size.width/12,color:Theme.of(context).primaryColor),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: listWidget.elementAt(_page),
    );
  }
}
