

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/PdfFileScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

showSnackBar(text, context){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text, style: TextStyle(color: AppColors.colorBackground),),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: AppColors.colorSecondary,
  ));
}
showSnackBarWithButton(text, context, path){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text, style: TextStyle(color: AppColors.colorBackground),)),
        TextButton(onPressed: (){
            Get.to(()=>PdfFileScreen(path: path, isUrl: false));
        },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.colorBackground,
              foregroundColor: AppColors.colorBackground,
            ),
            child: Text("View",
          style: TextStyle(color: AppColors.colorSecondary),))
      ],
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: AppColors.colorSecondary,
  ));
}