import 'package:flutter/material.dart';
import 'package:wms/constants_components/enter_way.dart';
import 'package:wms/modles/constant_colors.dart';
import 'package:wms/mywigets/birth_day_field.dart';
import 'package:wms/mywigets/email_field.dart';
import 'package:wms/mywigets/my_home_page.dart';
import 'package:wms/mywigets/name_field.dart';
import 'package:wms/mywigets/password_field.dart';
import 'package:wms/mywigets/phone_field.dart';
import 'package:wms/mywigets/pick_image_and_show_it.dart';
import 'package:wms/static_classes/user_informations.dart';

GlobalKey<FormState> formState = GlobalKey();
GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: ConstantColors.backgroundColorSignIn,
      body: SingleChildScrollView(
        child: Form(
          key: formState,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: NameField(label: 'First Name'),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: NameField(label: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: NameField(label: 'Location'),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: BirthDayField(label: 'Birth Day'),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: EmailField(enterType: EnterWay.sinUp),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: PhoneField(enterType: EnterWay.sinUp),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: PasswordField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: PickImageAndShowIt(scaffoldState: scaffoldState),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: MaterialButton(
                    color:
                        ConstantColors.backgroundColorTabBarIndicatorSelected,
                    padding: const EdgeInsets.all(15),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    minWidth: double.infinity,
                    onPressed: () {
                      formState.currentState!.save();
                      if (formState.currentState!.validate() &&
                          UserInformations.image != null) {
                        formState.currentState!.save();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
