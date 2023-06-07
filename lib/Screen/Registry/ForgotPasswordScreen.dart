import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var emailController = TextEditingController();

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.colorBackground, size: 25,),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(color: AppColors.colorSecondary, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! * 0.25,
              height: SizeConfig.screenWidth! * 0.25,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/forgot_icon@2x.png",
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Text(
                      "?",
                      style: TextStyle(
                          color: AppColors.colorDarkGrey,
                          fontSize: SizeConfig.screenWidth! * 0.07),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.07,
            ),
            Text(
              "Please Enter Your Email Address To\nReceive a Verification Code",

              style: TextStyle(color: AppColors.colorDarkGrey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.07,
            ),
            Text("Email Address",style: TextStyle(color: AppColors.textColor, fontSize: 18),),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.01,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.069,
              width: SizeConfig.screenWidth!,
              child: TextFormField(
                controller: emailController,
                style: TextStyle(color: AppColors.colorSecondary),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !value.contains('@') ||
                      !value.contains('.')) {
                    return 'Invalid Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: AppColors.colorBackground.withOpacity(0.5),
                    filled: true,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    hintText: "naeem.lashari@gmail.com",
                    hintStyle: TextStyle(color: AppColors.colorDarkGrey),
                    labelStyle: TextStyle(color: AppColors.colorSecondary),
                    border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.colorDarkGrey, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.colorSecondary, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: AppColors.colorSecondary, width: 1))),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: SizeConfig.screenHeight! * 0.067,
                width: SizeConfig.screenWidth!,
                decoration: BoxDecoration(
                    color: AppColors.colorBackground,
                    // borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        tileMode: TileMode.clamp,
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          AppColors.colorSecondary,
                          AppColors.colorSecondary.withOpacity(0.7)
                        ])),
                child: ElevatedButton(
                  onPressed: () async{
                    if(emailController.text == null ||
                        emailController.text.isEmpty ||
                        !emailController.text.contains('@') ||
                        !emailController.text.contains('.')){
                      return;
                    }
                   await controller.forgotPassword(email: emailController.text, context: context);
                  },
                  style:
                  ElevatedButton.styleFrom(primary: Colors.transparent),
                  child: Text(
                    'Send',
                    style: TextStyle(fontSize: 22, color: AppColors.colorBackground),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.09,
            ),
            Center(
              child: Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator(
                color: AppColors.colorSecondary,
              )
                  : const SizedBox()),
            )
          ],
        ),
      ),
    );
  }
}
