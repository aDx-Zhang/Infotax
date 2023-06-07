import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Screen/HomePage.dart';
import 'package:info_tax_square/Screen/Registry/LoginScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/Utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: Container(
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! * 0.25,
              height: SizeConfig.screenWidth! * 0.25,
              child: Image.asset(
                "assets/logos/logo@2x.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    () async {
      Future.delayed(const Duration(milliseconds: 1500), () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = prefs.getString(User_Id);
        if (user != null) {
          print("user available");
          // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        } else {
          print("user not available");
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
          // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      });
    }();
  }
}
