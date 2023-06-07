

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/PushNotificationService.dart';
import 'package:info_tax_square/Screen/AboutUs/AboutUsScreen.dart';
import 'package:info_tax_square/Screen/Category/ArticleCategoryScreen.dart';
import 'package:info_tax_square/Screen/Category/ArticleCategoryListScreen.dart';
import 'package:info_tax_square/Screen/Index/IndexScreen.dart';
import 'package:info_tax_square/Screen/Inquiry/InquiryScreen.dart';
import 'package:info_tax_square/Screen/Message/MessagesScreen.dart';
import 'package:info_tax_square/Screen/SecretaryStates/SecretaryStatesScreen.dart';
import 'package:info_tax_square/Screen/Services/ServicesScreen.dart';
import 'package:info_tax_square/main.dart';

class HomeController extends GetxController{
  static HomeController instance = Get.find();
  var onBackPressed = false.obs;
  var icons = [
  FontAwesomeIcons.layerGroup,
  FontAwesomeIcons.handHoldingDroplet,
  FontAwesomeIcons.comment,
  FontAwesomeIcons.ellipsis,
  ];
  var pages = [
    ArticleCategoryScreen(),
    ServicesScreen(),
    MessagesScreen(),
    AboutUsScreen(),
    IndexScreen(),
    SecretaryStatesScreen(),
    InquiryScreen(),
    ArticleCategoryListScreen()
  ].obs;
  var categoryPages = [

  ].obs;
  var servicePages = [].obs;
  var appTitles = [
    "Categories",
    "Services",
    "Message",
    "About Us",
    "Home",
    "States",
    "My Download Center",
    "My Message",
    "Upload Documents",
    "Services",
    "Profile",
    "Edit Profile",
  ].obs;

  var appBarText = "Home".obs;
  setAppBarText(text){
    appBarText.value = text;
  }

  var currentIndex = 4.obs;

  getIndex() =>currentIndex.value;
  setIndex(index){
    currentIndex.value = index;
    update();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }
  void closeDrawer() {
    scaffoldKey.currentState!.closeDrawer();
  }

  void openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
  void closeEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
  refreshToken() async{
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    messaging.onTokenRefresh.listen((event) async{
      var deviceId = event.toString();
      print("deviceId $deviceId ");
      var sendId = await Api().updateDeviceId(deviceId);
      var json = jsonDecode(sendId);
      print(json["message"]);
    });
  }
  @override
  void onInit() {
    super.onInit();
    PushNotificationService.init(flutterLocalNotificationsPlugin);
    refreshToken();
  }

}