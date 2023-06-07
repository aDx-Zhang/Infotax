

import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAlert(){
  return Get.dialog(Container(), barrierDismissible: true);
}