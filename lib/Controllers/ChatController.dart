

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Model/Chat.dart';
import 'package:info_tax_square/Model/NotificationModel.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController{
  var isMessageLoaded = false.obs;
  var messagesList = <Chat>[].obs;
  var scrollController = ScrollController();

  var isNotificationLoaded = false.obs;
  RxList<NotificationModel> notificationsList = <NotificationModel>[].obs;

  getNotifications() async{
    isNotificationLoaded(true);
    try{
      var response = await Api().getNotification();
      print("notifications" +  response);
      if(response != null){
        notificationsList.assignAll(allNotificationFromJson(response));
      }


    }
    catch(e){
      print(e);
    }
    finally{
      isNotificationLoaded(false);

    }
    update();
  }


  filterChats(){
    var startDate = DateTime.utc(2021, 05, 21);
    var endDate = DateTime.utc(2021, 08, 31);
    var filteredList = [].obs;
    for (var i = 0; i < messagesList.length; i += 1) {
      var date = formatDate(messagesList[i]);
      if (date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0) {
        filteredList.add(messagesList[i]);
      }
    }
    print(filteredList);
    return filteredList;
  }
  formatDate(date){
    var dateTime =  DateTime.parse("$date");
    var stdTime =  DateFormat('MMM d, yy hh:mm a').format(dateTime).toString();
    return stdTime;
  }
  convertToTimeStamp(dateAndTime){

  }
  getChats() async{
    try{
      isMessageLoaded(true);
      var data = await Api().getChatsHistory();
      if(data != null){
        messagesList.assignAll(chatsListFromJson(data).reversed);
      }
    }
    catch(e){
      print(e);
    }
    finally{
      isMessageLoaded(false);
    }
    update();
  }
  sendMessage(message) async{
    try{
      var data = await Api().sendChat(message: message);
      var jsonData = jsonDecode(data);
      if(jsonData["status"]){
          messagesList.add(Chat(message: message, msgDate: DateTime.now().toString(), sentBy: "user"));
      }
    }
    catch(e){
      print(e);
    }
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    update();

  }

  @override
  void onInit() {
    super.onInit();
    getChats();
    filterChats();
    getNotifications();
  }
}