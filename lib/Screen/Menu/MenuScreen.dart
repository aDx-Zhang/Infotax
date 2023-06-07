import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/DownloadCentreScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/DownloadFormScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/UploadScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/UploadedListScreen.dart';
import 'package:info_tax_square/Screen/Notification/NotificationScreen.dart';
import 'package:info_tax_square/Screen/Profile/ProfileScreen.dart';
import 'package:info_tax_square/Screen/Registry/CreateNewPasswordScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

import '../../MainAccess.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);
  var controller = Get.put(AuthController());
  var documentController = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        centerTitle: true,
        title: Text(
          "Menu",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: AppColors.colorBackground, size: 22,)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          buildListTile("assets/images/profile_icon@2x.png", "Profile", () async{
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));
             Get.find<ApiController>().getUserProfile();
            Get.to(()=>ProfileScreen(), transition: Transition.downToUp );
          }),
          buildListTile("assets/images/change_password@2x.png", "Change Password", (){
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateNewPasswordScreen()));
            Get.to(()=>CreateNewPasswordScreen(), transition: Transition.downToUp );
          }),
          buildListTile("assets/images/download_documents@2x.png", "Download Forms", () async{
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>DownloadFormScreen()));
          documentController.getDownloadForms();
            Get.to(()=>DownloadFormScreen(), transition: Transition.downToUp );
          }),
          buildListTile("assets/images/my_order@2x.png", "Download Documents", () async{
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>DownloadCentreScreen()));
             documentController.getDownloadDocs();
            Get.to(()=>DownloadCentreScreen(), transition: Transition.downToUp );
          }),
          buildListTile("assets/images/upload_documents@2x.png", "Upload Documents", () async{
            //  Navigator.push(context, MaterialPageRoute(builder: (_)=>UploadScreen(),));
             documentController.getMyUploadedDocs();
            Get.to(()=>UploadedListScreen(), transition: Transition.downToUp );
          }),
          buildListTile("assets/images/logout@2x.png", "Logout", () async{
            await controller.logout();
          }),
        ],
      ),
    );
  }

  buildListTile(icon, text, onClick) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onClick,
        leading: Container(
          width: 70,
            height: 70,
            padding: EdgeInsets.all(5),
            child:Image.asset(icon),
        ),
        title: Text(text, style: TextStyle(color: AppColors.colorDarkGrey, fontSize: 20),),
        trailing: Icon(Icons.arrow_forward_ios_rounded, color: AppColors.colorDarkGrey, size: 18,),
      ),
    );
  }
}
