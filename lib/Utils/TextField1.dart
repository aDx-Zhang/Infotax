

import 'package:flutter/material.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class TextField1 extends StatelessWidget {
  TextField1({this.controller, this.hintText, this.noOfLines, this.keyboardType});
  var controller;
  var hintText;
  var noOfLines;
  var keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val){
        if(val!.isEmpty){
          return "not empty";
        }
        return null;
      },
      controller: controller,
      maxLines: noOfLines,
      keyboardType: keyboardType ?? TextInputType.text,
      style: TextStyle(
          color: AppColors.textColor,
          fontSize: 15
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.colorDarkGrey.withOpacity(0.7),
          fontSize: 15
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorDarkGrey.withOpacity(0.5), width: 1),
          borderRadius: BorderRadius.circular(5)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorDarkGrey.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(5)
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorDarkGrey.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(5)
        ),
      ),
    );
  }
}
