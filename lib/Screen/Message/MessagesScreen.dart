import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Utils/Colors.dart';

import '../../Controllers/ChatController.dart';
import 'MessagesList.dart';

class MessagesScreen extends StatelessWidget {
   MessagesScreen({Key? key}) : super(key: key);
  var controller = Get.put(ChatController());
  var messageController = TextEditingController();
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ChatController>(builder: (controller) {
        return ListView.builder(
          controller: controller.scrollController,
            itemCount: controller.messagesList.length,
            reverse: false,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
          return MessagesList(
            chat: controller.messagesList[index],
          );
        });
      }),
      bottomNavigationBar: Container(
        height: 50,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.colorSecondary,
            width: 1
          )
        ),
        child: Row(
          children: [
            Expanded(child: TextField(
              controller: messageController,
              cursorColor: AppColors.textColor,
              keyboardType: TextInputType.text,
              style: TextStyle(color: AppColors.textColor, fontSize: 15),
              decoration: InputDecoration.collapsed(
                hintText: "Type Message Here...",
              ),
            )),
            IconButton(
                onPressed: () async{
                  //scrollController.jumpTo(scrollController.position.maxScrollExtent);
                  await controller.sendMessage(messageController.text);
                  messageController.text = "";
                },
                icon: Icon(
                  Icons.send,
                  color: AppColors.colorSecondary,
                ))
          ],
        ),
      ),
    );
  }
}
