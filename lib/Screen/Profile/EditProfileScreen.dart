import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Model/UserProfile.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key, this.userProfile}) : super(key: key);
  UserProfile? userProfile;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var companyController = TextEditingController();
  var mailingAddressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var zipController = TextEditingController();
  var phoneController = TextEditingController();
  var faxesController = TextEditingController();

  var checkApi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/edit_profile_pic.png",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Form(
                  child: Column(
                children: [
                  createTextFiled(
                      controller: firstNameController, hint: "First Name"),
                  createTextFiled(
                      controller: lastNameController, hint: "Last Name"),
                  createTextFiled(
                      controller: emailController,
                      hint: "Email",
                      inputType: TextInputType.emailAddress),
                  createTextFiled(
                      controller: companyController, hint: "Company Name"),
                  createTextFiled(
                      controller: mailingAddressController,
                      hint: "Mailing Address"),
                  createTextFiled(controller: cityController, hint: "City"),
                  createTextFiled(controller: stateController, hint: "State"),
                  createTextFiled(
                      controller: zipController,
                      hint: "Zip",
                      inputType: TextInputType.number),
                  createTextFiled(
                      controller: phoneController,
                      hint: "Phone",
                      inputType: TextInputType.number),
                  createTextFiled(
                      controller: faxesController,
                      hint: "Faxes",
                      inputType: TextInputType.number),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: Get.height,
                    child: TextButton(
                        onPressed: () async {
                          await updateProfile();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.alterColor,
                          backgroundColor: AppColors.alterColor,
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(height: 30),
                  checkApi ? Center(child: CircularProgressIndicator(color: AppColors.colorSecondary,)) : SizedBox()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  updateProfile() async {
   var updateData = "";
    try{
      setState(() {
        checkApi = true;
      });
      var data = await Api().updateUserProfile(UserProfile(
          firstname: firstNameController.text,
          lastname: lastNameController.text,
          secEmail: emailController.text,
          companyname: companyController.text,
          address: mailingAddressController.text,
          city: cityController.text,
          fax: faxesController.text,
          phone: phoneController.text,
          state: stateController.text,
          zipcode: zipController.text,
          uname: ""));
      var json = jsonDecode(data);
      updateData = json["message"];
      print(json);
    }
    catch(e){
      updateData = e.toString();
      print(e);
    }
    finally{
      setState(() {
        checkApi = false;
      });
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(updateData)));
  }

  createTextFiled({controller, hint, inputType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        style: TextStyle(color: AppColors.textColor.withOpacity(0.9)),
        cursorColor: AppColors.textColor.withOpacity(0.9),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textColor.withOpacity(0.5)),
          labelStyle: TextStyle(color: AppColors.textColor.withOpacity(0.9)),
          contentPadding: const EdgeInsets.only(bottom: 3),
          border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textColor.withOpacity(0.5))),
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textColor.withOpacity(0.7))),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.textColor.withOpacity(0.7))),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.userProfile!.firstname!;
    lastNameController.text = widget.userProfile!.lastname!;
    emailController.text = widget.userProfile!.secEmail!;
    companyController.text = widget.userProfile!.companyname!;
    mailingAddressController.text = widget.userProfile!.address!;
    cityController.text = widget.userProfile!.city!;
    stateController.text = widget.userProfile!.state!;
    zipController.text = widget.userProfile!.zipcode!;
    phoneController.text = widget.userProfile!.phone!;
    faxesController.text = widget.userProfile!.fax!;
  }
}
