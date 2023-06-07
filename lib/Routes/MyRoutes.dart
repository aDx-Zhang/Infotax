

import 'package:get/get.dart';
import 'package:info_tax_square/Bindings/ApiBinding.dart';
import 'package:info_tax_square/Bindings/AuthBinding.dart';
import 'package:info_tax_square/Bindings/DownloadBiding.dart';
import 'package:info_tax_square/Controllers/DocumentController.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/DownloadCentreScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/DownloadFormScreen.dart';
import 'package:info_tax_square/Screen/DownloadAndUpload/UploadScreen.dart';
import 'package:info_tax_square/Screen/HomePage.dart';
import 'package:info_tax_square/Screen/Menu/MenuScreen.dart';
import 'package:info_tax_square/Screen/Message/MessagesScreen.dart';
import 'package:info_tax_square/Screen/Profile/EditProfileScreen.dart';
import 'package:info_tax_square/Screen/Profile/ProfileScreen.dart';
import 'package:info_tax_square/Screen/Splash/SplashScreen.dart';

import '../Bindings/MainBinding.dart';

class MyRoutes{

  static const String splash = "/splash";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgot";
  static const String changePassword = "/change_password";
  static const String home = "/home";
  static const String index = "/index";
  static const String menu = "/menu";
  static const String profile = "/profile";
  static const String editProfile = "/edit_profile";
  static const String message = "/message";
  static const String service = "/service";
  static const String secretaryStates = "/secretary_states";
  static const String notification = "/notification";
  static const String downloadCentre = "/download_centre";
  static const String downloadForm = "/download_form";
  static const String uploadDoc = "/upload_doc";

  static List<GetPage> pages = [
    GetPage(name: splash, page:()=> SplashScreen(), binding: AuthBinding()),
    GetPage(name: home, page:()=> HomePage(), binding: MainBinding()),
    GetPage(name: menu, page:()=> MenuScreen(), binding: ApiBinding()),
    GetPage(name: profile, page:()=> ProfileScreen(), binding: ApiBinding()),
    GetPage(name: editProfile, page:()=> EditProfileScreen(), binding: ApiBinding()),
    GetPage(name: downloadCentre, page:()=> DownloadCentreScreen(), binding: DownloadBiding()),
    GetPage(name: downloadForm, page:()=> DownloadFormScreen(), binding: DownloadBiding()),
    GetPage(name: uploadDoc, page:()=> UploadScreen(), binding: DownloadBiding()),
  ];
}