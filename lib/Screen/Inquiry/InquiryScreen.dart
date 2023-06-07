import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/Utils/TextField1.dart';

class InquiryScreen extends StatefulWidget {
  InquiryScreen({Key? key}) : super(key: key);

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNoController = TextEditingController();
  var commentsController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  validateAndSave(context) async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      await sendInquiry(context);
      fullNameController.text = "";
      emailController.text = "";
      phoneNoController.text = "";
      commentsController.text = "";
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }
  sendInquiry(context) async{
    var response = await Api().sendInquiry(
        full_name: fullNameController.text,
        email_id: emailController.text,
        phone_no: phoneNoController.text,
        comments: commentsController.text);
    var data = jsonDecode(response);
    var snackBar = SnackBar(content: Text(data["message"]));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: AppColors.colorBackground,)),
        title: Text("Inquiry", style: TextStyle(color: AppColors.colorBackground, fontSize: 22),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        SizedBox(height: 20),
            Text("Please fill the form below", style: TextStyle(color: AppColors.colorDarkGrey, fontWeight: FontWeight.bold, fontSize: 22),),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFE5EAE8),
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColors.colorBackground,
                          borderRadius: BorderRadius.circular(10)),
                      child: Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              TextField1(
                                  controller: fullNameController,
                                  hintText: "Name",
                                  noOfLines: 1),
                              SizedBox(height: 10),
                              TextField1(
                                  controller: emailController,
                                  hintText: "Email",
                                  noOfLines: 1,
                                  keyboardType: TextInputType.emailAddress),
                              SizedBox(height: 10),
                              TextField1(
                                controller: phoneNoController,
                                hintText: "Phone No",
                                noOfLines: 1,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 50),
                              TextField1(
                                  controller: commentsController,
                                  hintText: "Comments",
                                  noOfLines: 5),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: AppColors.colorSecondary,
                            backgroundColor: AppColors.colorSecondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        onPressed: () async{
                          await validateAndSave(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Send",
                              style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
                            ),
                            Icon(
                              Icons.send,
                              color: AppColors.colorBackground,
                            )
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    homeController.setIndex(5);
    homeController.setAppBarText("Inquiry");
    return true;
  }
}
