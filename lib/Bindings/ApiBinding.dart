

import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';

class ApiBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ApiController());
  }

}