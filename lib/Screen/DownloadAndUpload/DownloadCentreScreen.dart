import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/Utils/SearchFeild.dart';

import 'components/DownloadCenterCardDesign.dart';

class DownloadCentreScreen extends GetView<DocumentController> {
    DownloadCentreScreen({Key? key}) : super(key: key);

    var controller = Get.put(DocumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorSecondary,
        title: Text("My Download Centre",  style: TextStyle(color: AppColors.colorBackground, fontSize: 22),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            controller.getDownloadDocs();
          }, icon: Icon(Icons.refresh), color: AppColors.colorBackground,)
        ],
      ),
      body: Column(
        children: [
          // SearchField(),
          SizedBox(height: 10),
          Expanded(
            child: GetBuilder<DocumentController>(builder: (controller) {
              return controller.isDownloadDocLoaded.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorSecondary,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.downloadDocs.length,
                          itemBuilder: (context, index) {
                            var downloadDoc = controller.downloadDocs[index];
                            return DownloadCenterCardDesign(
                              downloadDoc: downloadDoc,
                              index: index,
                              controller: controller,
                            );
                          }),
                    );
            }),
          ),
        ],
      ),
    );
  }
}
