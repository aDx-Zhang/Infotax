

import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Controllers/AuthController.dart';
import 'package:info_tax_square/Controllers/HomeController.dart';

class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.put(HomeController());
    Get.lazyPut(() => ApiController());
  }

}