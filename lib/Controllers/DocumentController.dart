import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Model/DownloadDoc.dart';
import 'package:info_tax_square/Model/DownloadForm.dart';
import 'package:info_tax_square/Model/UploadedDoc.dart';
import 'package:info_tax_square/Utils/AppUtils.dart';
import 'package:info_tax_square/Utils/showSnackBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:path/path.dart' as path;

class DocumentController extends GetxController {

  static DocumentController instance = Get.find();
  var isDownloadDocLoaded = false.obs;
  RxList<DownloadDoc> downloadDocs = <DownloadDoc>[].obs;
  RxList<DownloadDoc> filterDownloadDocs = <DownloadDoc>[].obs;

  var isDownloadFormLoaded = false.obs;
  RxList<DownloadForm> downloadForms = <DownloadForm>[].obs;
  RxList<DownloadForm> filterDownloadForms = <DownloadForm>[].obs;

  var isUploadedDocsLoaded = false.obs;
  RxList<UploadedDoc> uploadedDocs = <UploadedDoc>[].obs;

  var progress = "0".obs;

  var directory = "".obs;

  var ifDocumentDownloaded = false.obs;

  // FlutterLocalNotificationsPlugin? notificationsPlugin;

  getDownloadDocs() async {
    try {
      isDownloadDocLoaded(true);
      var response = await Api().getDownloadDoc();
      // todo
      if(response["status"]){
        print("docs available");
      }
      if (response != null) {
        downloadDocs.assignAll(allDownloadDocFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isDownloadDocLoaded(false);
    }
    update();
  }

  getFilterDownloadDocs(text) {
    filterDownloadDocs.assignAll(downloadDocs
        .where((form) =>
            equalsIgnoreCase(form.docName).contains(equalsIgnoreCase(text)))
        .toList());
    update();
    print(filterDownloadForms);
    return filterDownloadForms.length;
  }

  getDownloadForms() async {
    try {
      isDownloadFormLoaded(true);
      var response = await Api().getDownloadedForm();
      if (response != null) {
        downloadForms.assignAll(allDownloadFormFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isDownloadFormLoaded(false);
    }
    update();
  }

  getMyUploadedDocs() async {
    try {
      isUploadedDocsLoaded(true);
      var response = await Api().getMyUploadDoc();
      if (response != null) {
        uploadedDocs.assignAll(allUploadedDocsFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isUploadedDocsLoaded(false);
    }
    update();
  }

  getFilterDownloadForm(text) {
    filterDownloadForms.assignAll(downloadForms
        .where((form) =>
            equalsIgnoreCase(form.title).contains(equalsIgnoreCase(text)))
        .toList());
    update();
    print(filterDownloadForms);
    return filterDownloadForms.length;
  }

  Future downloadPdf(String url, String fileName, context, onProgress) async {
    ifDocumentDownloaded(true);
    Map<String, dynamic> result = {
      "isSuccess": false,
      "filePath": null,
      "error": null
    };
    try {
      if (await requestPermission()) {
        // final dir = await getDownloadDirectory();
        // final savePath = path.join(dir.path, "${fileName}.pdf");

        final dir = await getDownloadDirectoryPath();
        var filePath = dir + '${fileName}.pdf';
        print(filePath);
        var response = await Dio()
            .download(url, filePath.trim(), onReceiveProgress: onProgress);
        print(response.statusMessage);
        if (response.statusCode == 200) {
          showSnackBarWithButton("Download successfully you can view pdf in $filePath", context, filePath);
        }
        result['isSuccess'] = response.statusCode == 200;
        result['filePath'] = filePath;
      } else {
        showSnackBar("Please enable permission from app setting", context);
      }
    } catch (e) {
      print(e);
      result['error'] = e.toString();
    } finally {
      ifDocumentDownloaded(false);
    }
  }

  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      Directory? directory;
      directory = await getExternalStorageDirectory();
      return directory!;
    }
    return getApplicationDocumentsDirectory();
  }

  Future getDownloadDirectoryPath() async {
    var directory;
    bool dirDownloadExists = true;
    if (Platform.isIOS) {
      directory = await getDownloadsDirectory();
      return directory!;
    } else {
      directory = "/storage/emulated/0/Download/";

      dirDownloadExists = await Directory(directory).exists();
      if (dirDownloadExists) {
        directory = "/storage/emulated/0/Download/";
      } else {
        directory = "/storage/emulated/0/Downloads/";
      }
    }
    return directory;
  }

  Future<bool> requestPermission() async {
    final permission = await Permission.storage.request();
    if (permission.isGranted) {
      return true;
    } else if (permission.isDenied) {
      await Permission.storage.request();
      return false;
    } else if (permission.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return false;
    }
  }

  @override
  void onInit() async {
    super.onInit();

    getDownloadDocs();
    getDownloadForms();
    getMyUploadedDocs();
  }
}
