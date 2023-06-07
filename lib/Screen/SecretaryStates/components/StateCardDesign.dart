

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class StateCardDesign extends StatelessWidget {
  StateCardDesign({Key? key, required this.titleId, required this.title, required this.url, required this.totalServices, this.onTap}) : super(key: key);
  String titleId;
  String title;
  String url;
  String totalServices;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.colorSecondary,
              width: 3
            )
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              margin: EdgeInsets.only(left: 80),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.colorBackground,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.colorSecondary,
                  width: 2
                )
              ),
              child: Text(title, style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
