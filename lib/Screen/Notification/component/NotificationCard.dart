import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Model/NotificationModel.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class NotificationCard extends StatelessWidget {
  NotificationCard({Key? key, required this.notificationModel}) : super(key: key);
  NotificationModel notificationModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * 0.10,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.colorDarkGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ListTile(
        title: Text(
          notificationModel.title,
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          notificationModel.detail,
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
        trailing: Text(
          "${notificationModel.date}",
          style: TextStyle(
              color: AppColors.textColor,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
