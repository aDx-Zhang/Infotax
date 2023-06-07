

import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';

class DownloadBiding extends Bindings{
  @override
  void dependencies() {
    Get.put(DocumentController());
  }

}