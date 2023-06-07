import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Utils/Colors.dart';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var fileNameController = TextEditingController();
  var fileText = 'PDF Document';
  File? file;
  var isLoaded = false;
  var url = "https://infotaxsquare.com/api/uploaddoc.php";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorSecondary,
        title: Text(
          "Upload Documents",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
          inAsyncCall: isLoaded,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.colorBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Document Name',
                                hintStyle: TextStyle(
                                    color: AppColors.colorDarkGrey, fontSize: 17),
                                labelStyle: TextStyle(
                                    color: AppColors.colorDarkGrey,
                                    fontSize: 17)),
                            style: TextStyle(
                                color: AppColors.colorDarkGrey, fontSize: 17),
                            controller: fileNameController,
                          ),
                          width: Get.width,
                          height: 50,
                          // alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.textColor.withOpacity(0.3))),
                        ),
                        SizedBox(height: 50),
                        Container(
                          width: Get.width,
                          height: 60,
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.textColor.withOpacity(0.3))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  fileText,
                                  style: TextStyle(
                                      color: AppColors.colorDarkGrey,
                                      fontSize: 17),
                                ),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: AppColors.colorSecondary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      allowedExtensions: ['pdf'],
                                      allowMultiple: false,
                                      type: FileType.custom,
                                    );

                                    if (result != null) {
                                      setState(() {
                                        file = File(result.files.single.path!);
                                        fileText = file!.path;
                                      });
                                    } else {
                                      file = null;
                                      fileText = "";

                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      "Choose File",
                                      style: TextStyle(
                                          color: AppColors.colorBackground),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(height: 150),
                        TextButton(
                            onPressed: () async {
                              // print("path" + file!.path);
                              // print("uri");
                              // print(file!.path);
                              // print(Uri.parse(file!.uri).toString());

                              if (fileNameController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "please provide document name")));
                              } else if (file == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("please select pdf file")));
                              } else {
                                await uploadPdfFile();
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.alterColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Upload",
                                    style: TextStyle(
                                        color: AppColors.colorBackground,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.upload_outlined,
                                    color: AppColors.colorBackground,
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                  // isLoaded
                  //     ? Container(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  //         margin:
                  //             EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  //         decoration: BoxDecoration(
                  //             color: AppColors.colorSecondary,
                  //             borderRadius: BorderRadius.circular(30)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               "Sending File",
                  //               style: TextStyle(
                  //                 color: AppColors.colorBackground,
                  //               ),
                  //             ),
                  //             SizedBox(width: 20),
                  //             SizedBox(
                  //                 height: 20,
                  //                 width: 20,
                  //                 child: CircularProgressIndicator(
                  //                   color: AppColors.colorBackground,
                  //                 ))
                  //           ],
                  //         ),
                  //       )
                  //     : SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Future uploadPdfFile() async {
    var fileName = file!.path.split('/').last;

    setState(() {
      isLoaded = true;
    });

    var formData = dio.FormData.fromMap({
      "uid": "13821",
        "doc_name": "docName",
        "file_name": await dio.MultipartFile.fromFile(file!.path, filename: fileName,
           contentType: MediaType('application', 'pdf')

        )
    });

    try {
      var response = await dio.Dio().post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          print("sent $sent , total $total");
        },
      );
      var json = jsonDecode(response.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColors.colorSecondary,
          content: Text(json["message"], style: TextStyle(color: AppColors.colorBackground, fontSize: 22),)));
      print(json["message"]);
      print(response.toString());
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoaded = false;
      });
    }
  }

}
