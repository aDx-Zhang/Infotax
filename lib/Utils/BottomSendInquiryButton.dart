

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Screen/Inquiry/InquiryScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class BottomSendInquiryButton extends StatelessWidget {
  BottomSendInquiryButton({Key? key, this.text }) : super(key: key);
  var text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.colorSecondary,
          backgroundColor: AppColors.colorSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        onPressed: (){
          Get.to(()=>InquiryScreen());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
               text,
                style:
                TextStyle(color: AppColors.colorBackground, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
