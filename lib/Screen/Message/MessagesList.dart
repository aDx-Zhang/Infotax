import 'package:flutter/material.dart';
import 'package:info_tax_square/Model/Chat.dart';
import 'package:info_tax_square/Utils/AppUtils.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:intl/intl.dart';

class MessagesList extends StatelessWidget {
  MessagesList({Key? key, required this.chat}) : super(key: key);
  Chat chat;

  @override
  Widget build(BuildContext context) {
    return chat.sentBy == "user" ? userMessage(chat) : adminMessage(chat);
  }

  userMessage(chats) {
    return Container(
      child: Align(
          alignment: (Alignment.centerRight),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.message!,
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  formatDate(chat.msgDate!),
                  style: TextStyle(
                      color: AppColors.textColor.withOpacity(0.5), fontSize: 12),
                )
              ],
            ),
          )),
    );
  }

  adminMessage(chats) {
    return Align(
        alignment: (Alignment.centerLeft),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: AppColors.colorDarkGrey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chat.message!,
                style: TextStyle(color: AppColors.colorSecondary, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                formatDate(chat.msgDate!),
                style: TextStyle(
                    color: AppColors.textColor.withOpacity(0.5), fontSize: 12),
              )
            ],
          ),
        ));
  }

}
