import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ChatController.dart';
import 'package:info_tax_square/Screen/Notification/component/NotificationCard.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  var controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        leading: SizedBox(),
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward,
                color: AppColors.colorBackground,
                size: 22,
              ))
        ],
      ),
      body: GetBuilder<ChatController>(builder: (controller){
        return controller.isNotificationLoaded.value ?
        Center(child: CircularProgressIndicator(color: AppColors.alterColor,),):
        ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notificationsList.length,
            itemBuilder: (context, index) => NotificationCard(
              notificationModel: controller.notificationsList[index],
            )) ;
      }),
    );
  }
}
