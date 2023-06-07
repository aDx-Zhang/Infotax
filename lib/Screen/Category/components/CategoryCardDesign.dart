

import 'package:flutter/material.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class CategoryCardDesign extends StatelessWidget {
  CategoryCardDesign({Key? key, required this.title, required this.url, this.id, this.onTap}) : super(key: key);

  String title;
  String url;
  String? id;
  var onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      focusColor: AppColors.colorSecondary,
      hoverColor: AppColors.colorSecondary,
      splashColor: AppColors.colorSecondary,
      highlightColor: AppColors.colorSecondary,
      onTap: onTap,
      child: Container(
        height: 120,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.colorSecondary,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.colorSecondary, width: 3)),
        child: Text(
          title,
          style: TextStyle(
              color: AppColors.colorBackground,
              fontSize: 18
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 3,
        ),
      ),
    );
  }
}
