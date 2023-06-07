

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Model/UploadedDoc.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/PdfFileScreen.dart';
import 'package:info_tax_square/Utils/AppUtils.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class UploadedDocDesign extends StatelessWidget {
  UploadedDocDesign({Key? key, required this.uploadedDoc}) : super(key: key);
  Map<int, double> progress = {};
  UploadedDoc uploadedDoc;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.colorDarkGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(

        title: Text(
                "Doc Id: ${uploadedDoc.docId}",
                style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
                 uploadedDoc.docName,
                  style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
        ),
        trailing: TextButton(
          onPressed: (){
            Get.to(()=>PdfFileScreen(path: uploadedDoc.fileUrl, isUrl : true));
          },
          child: Text("View", style: TextStyle(color: AppColors.colorSecondary),),
        ),
      ),
    );
  }

}
