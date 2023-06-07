import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Config/SizeConfig.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Utils/AppData.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class IndexScreen extends StatelessWidget {
  IndexScreen({Key? key}) : super(key: key);
  var controller = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              width: SizeConfig.screenWidth!,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth! * 0.18,
                    height: SizeConfig.screenWidth! * 0.18,
                    child: Image.asset(
                      "assets/logos/logo@2x.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text("R", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  Text(
                    AppData.WEB_URL,
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Divider(
                      color: Colors.red,
                      thickness: 3,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.01,
                  ),
                  Text(
                    AppData.LICENSES_AND_PERMIT,

                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,

                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Obx(() => Container(
              decoration: BoxDecoration(
                  color: AppColors.colorBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Html(
                data: controller.indexData.value,
                style: {
                  "b": Style(
                    //  backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    color: AppColors.colorSecondary,
                    textDecorationColor: AppColors.colorSecondary,
                    fontSize: FontSize.xLarge,
                    fontWeight: FontWeight.bold,

                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    //   padding: EdgeInsets.all(10)
                  ),
                  "p": Style(
                    textDecorationColor: AppColors.textColor,
                    // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    wordSpacing: 2,
                    // letterSpacing: 1.5,
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "table": Style(
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  // some other granular customizations are also possible
                  "tr": Style(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "li": Style(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    textDecorationColor: AppColors.textColor,
                  ),
                  "th": Style(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "td": Style(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.topLeft,
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  // text that renders h1 elements will be red
                  "h1": Style(
                    color: Colors.red,
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                },
              ),
            )),
            SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                    color: AppColors.colorSecondary,
                    borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  onPressed: (){
                    homeController.setIndex(5);
                    homeController.setAppBarText("Secretary States");

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View Secretary States",
                        style: TextStyle(
                            color: AppColors.colorBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios,color: AppColors.colorBackground, size: 18, )
                    ],
                  ),
                )
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
      // floatingActionButton: SizedBox(
      //   height: 70,
      //   width: 70,
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.transparent,
      //     foregroundColor: Colors.transparent,
      //     heroTag: "btn2",
      //     onPressed: () {
      //       homeController.setIndex(6);
      //       homeController.setAppBarText("Contact Us");
      //     },
      //     elevation: 0,
      //     child: Image.asset(
      //       "assets/images/chat@2x.png",
      //       fit: BoxFit.cover,
      //       height: 70,
      //       width: 70,
      //     ),
      //   ),
      // ),
    );
  }
}
