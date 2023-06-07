import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Screen/Registry/ForgotPasswordScreen.dart';
import 'package:info_tax_square/Screen/Registry/SignupScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var controller = Get.put(AuthController());

  var isPasswordVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave(context) async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      await controller.login(
          email: emailController.text,
          password: passwordController.text,
          context : context
      );
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      resizeToAvoidBottomInset: false,
      body: Column(
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
          SizedBox(
            height: SizeConfig.screenHeight! * 0.07,
          ),
          Text(
            "Login",
            style: TextStyle(
                color: AppColors.colorSecondary,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: SizeConfig.screenHeight! * 0.03,
          ),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    SizedBox(
                    //  height: SizeConfig.screenHeight! * 0.070,
                      width: SizeConfig.screenWidth!,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.')) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        style: TextStyle(color: AppColors.colorSecondary),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          prefixIcon: Icon(
                            Icons.mail_outline_outlined,
                            color: AppColors.colorSecondary,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(color: AppColors.colorDarkGrey),
                          labelStyle:
                              TextStyle(color: AppColors.colorSecondary),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                          disabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: AppColors.colorSecondary, width: 1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    SizedBox(
                    //  height: SizeConfig.screenHeight! * 0.070,
                      width: SizeConfig.screenWidth!,
                      child: TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "password is empty";
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: isPasswordVisible ? false : true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscuringCharacter: "*",
                        style: TextStyle(color: AppColors.colorSecondary),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            prefixIcon: Icon(
                              Icons.lock_open_outlined,
                              color: AppColors.colorSecondary,
                            ),
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: AppColors.colorDarkGrey),
                            labelStyle:
                                TextStyle(color: AppColors.colorSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            disabledBorder:  OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: AppColors.colorSecondary, width: 1)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.colorDarkGrey,
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: SizeConfig.screenHeight! * 0.070,
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
                          onPressed: () async {
                            validateAndSave(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 22, color: AppColors.colorBackground),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight! * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ForgotPasswordScreen()));
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: AppColors.colorSecondary),
                            ))
                      ],
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
              )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(color: AppColors.colorDarkGrey),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignupScreen()));
                },
                child: Text(
                  "Sign up here.",
                  style: TextStyle(color: AppColors.colorSecondary),
                ))
          ],
        ),
      ),
    );
  }
}
