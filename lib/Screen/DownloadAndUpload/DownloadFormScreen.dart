import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/MainAccess.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/components/DownloadFormDesign.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:info_tax_square/Utils/SearchFeild.dart';

class DownloadFormScreen extends GetView<DocumentController> {
  DownloadFormScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();
  var controller = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorSecondary,
        title: Text(
          "Download Form",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.getDownloadForms();
            },
            icon: Icon(Icons.refresh),
            color: AppColors.colorBackground,
          )
        ],
      ),
      body: Column(
        children: [
          SearchField(
            controller: textController,
            onChange: (value) {
              controller.getFilterDownloadForm(value);
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: GetBuilder<DocumentController>(builder: (controller) {
              return controller.isDownloadFormLoaded.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorSecondary,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: textController.text.isEmpty
                              ? controller.downloadForms.length
                              : controller.filterDownloadForms.length,
                          itemBuilder: (context, index) {
                            var downloadForm =
                            textController.text.isEmpty
                                    ? controller.downloadForms[index]
                                    : controller.filterDownloadForms[index];
                            return DownloadFormDesign(
                              downloadForm: downloadForm,
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
