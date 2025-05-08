import 'package:flutter/material.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/screens/log_in.dart';
import 'package:wms/screens/sign_up.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>
    with SingleTickerProviderStateMixin {
  late Size size;
  TabController? tabController;
  double indicatorBorderRadius = 30;
  double tabBarTextHight = 100;
  double selectedLabelSize = 30;
  double unSelectedLabelSize = 20;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void check({required BuildContext context}) {
    size = MediaQuery.of(context).size;
    indicatorBorderRadius = size.height / 6;
    tabBarTextHight = size.width / 6;
    selectedLabelSize = size.width / 18;
    unSelectedLabelSize = size.width / 20;
  }

  @override
  Widget build(BuildContext context) {
    check(context: context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Get Start Now',

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: selectedLabelSize,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'Sign Up', height: tabBarTextHight),
            Tab(text: 'Log In', height: tabBarTextHight),
          ],

          dividerHeight: 0,
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: selectedLabelSize,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: unSelectedLabelSize,
          ),
          indicatorPadding: const EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

          splashBorderRadius: BorderRadius.all(
            Radius.circular(indicatorBorderRadius),
          ),
          indicator: BoxDecoration(
            color: ConstantColors.backgroundColorTabBarIndicatorSelected,
            borderRadius: BorderRadius.all(
              Radius.circular(indicatorBorderRadius),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [SignUp(), LogIn()],
      ),
    );
  }
}
