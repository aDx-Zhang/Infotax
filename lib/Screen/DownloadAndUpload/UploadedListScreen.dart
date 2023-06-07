import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/UploadScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/components/UploadedDocDesign.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class UploadedListScreen extends StatelessWidget {
  UploadedListScreen({Key? key}) : super(key: key);
  var controller = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorSecondary,
        title: Text(
          "My Upload Documents",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<DocumentController>(
          builder: (controller) {
        return ListView.builder(
            itemCount: controller.uploadedDocs.length,
            itemBuilder: (context, index) {
          return UploadedDocDesign(
            uploadedDoc:  controller.uploadedDocs[index],
          );
        });
      }),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextButton(
            onPressed: () {
              Get.to(() => UploadScreen());
            },
            style: TextButton.styleFrom(
                backgroundColor: AppColors.alterColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            child: Text(
              "Upload Doc",
              style: TextStyle(
                  color: AppColors.colorBackground,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
