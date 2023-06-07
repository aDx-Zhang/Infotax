import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/HomeController.dart';
import 'package:info_tax_square/PushNotificationService.dart';
import 'package:info_tax_square/Screen/Menu/MenuScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/main.dart';
import 'Notification/NotificationScreen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: AppColors.colorBackground,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.colorSecondary,
          leading: IconButton(
            onPressed: () {
              controller.openDrawer();
            },
            icon: Icon(
              Icons.home_filled,
              color: AppColors.colorBackground,
              //size: 22,
            ),
          ),
          title: Obx(() =>
              Text(
                controller.appBarText.value,
                style: TextStyle(
                    color: AppColors.colorBackground, fontSize: 22),
              )),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  controller.openEndDrawer();
                },
                icon: Icon(
                  Icons.notifications,
                  color: AppColors.colorBackground,
                  //  size: 22,
                ))
          ],
        ),
        drawer: MenuScreen(),
        endDrawer: NotificationScreen(),
        bottomNavigationBar: GetBuilder<HomeController>(
          builder: (controller) =>
              AnimatedBottomNavigationBar(
                icons: controller.icons,
                activeColor: AppColors.colorSecondary,
                inactiveColor: AppColors.colorDarkGrey,
                activeIndex: controller.currentIndex.value,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.verySmoothEdge,
                onTap: (index) {
                  controller.setIndex(index);
                  controller.setAppBarText(controller.appTitles[index]);
                  print(index);
                },
              ),
        ),
        body: Obx(() => controller.pages[controller.currentIndex.value]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              isExtended: false,
              backgroundColor: Colors.transparent,
              heroTag: "btn1",
              onPressed: () async {
                controller.setIndex(4);
                controller.setAppBarText("Home");
                // PushNotificationService.showNotification(
                //     id:  1,
                //     title: "message.notification!.title!",
                //     body: "message.notification!.body!",
                //     fln: flutterLocalNotificationsPlugin);
              },
              elevation: 0,
              child: Image.asset(
                "assets/images/home@3x.png",
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    //Checks if current Navigator still has screens on the stack.
    if (_yourKey.currentState!.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      //If no other WillPopScope exists, it returns true
      _yourKey.currentState!.maybePop();
      return Future<bool>.value(false);
    }
//if nothing remains in the stack, it simply pops
    return Future<bool>.value(true);
  }
}