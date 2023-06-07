import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  CreateNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  var currentPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  var controller = Get.put(AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validateAndSave(context) async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      controller.changePassword(
          currentPassword: currentPasswordController.text,
          newPassword: confirmNewPasswordController.text,
          context: context
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
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.colorSecondary,
            size: 25,
          ),
        ),
        title: Text(
          "Create New Password",
          style: TextStyle(color: AppColors.colorSecondary, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * 0.07,
              ),
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
                "You New Password Must Be Difference\nFrom Previously Used Password",
                style: TextStyle(color: AppColors.colorDarkGrey, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.07,
              ),
              Text(
                "Current Password",
                style: TextStyle(color: AppColors.textColor, fontSize: 18),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.01,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please provide your old password-";
                          }
                          return null;
                        },
                        controller: currentPasswordController,
                        style: TextStyle(color: AppColors.colorSecondary),
                        decoration: InputDecoration(
                            fillColor: AppColors.colorBackground.withOpacity(0.5),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            hintText: "current password",
                            hintStyle: TextStyle(color: AppColors.colorDarkGrey),
                            labelStyle:
                                TextStyle(color: AppColors.colorSecondary),
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
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.07,
                      ),
                      Text(
                        "New Password",
                        style:
                            TextStyle(color: AppColors.textColor, fontSize: 18),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.01,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please provide new password";
                          }
                          return null;
                        },
                        controller: confirmNewPasswordController,
                        style: TextStyle(color: AppColors.colorSecondary),
                        decoration: InputDecoration(
                            fillColor: AppColors.colorBackground.withOpacity(0.5),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            hintText: "new password",
                            hintStyle: TextStyle(color: AppColors.colorDarkGrey),
                            labelStyle:
                                TextStyle(color: AppColors.colorSecondary),
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
                    ],
                  )),
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
                            AppColors.colorPrimary
                          ])),
                  child: ElevatedButton(
                    onPressed: () async {
                     await validateAndSave(context);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.transparent),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 22, color: AppColors.colorBackground),
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
      ),
    );
  }
}
