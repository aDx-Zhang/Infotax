import 'dart:convert';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Api/RegisterApi.dart';
import 'package:info_tax_square/Screen/HomePage.dart';
import 'package:info_tax_square/Screen/Registry/LoginScreen.dart';
import 'package:info_tax_square/Utils/Constants.dart';
import 'package:info_tax_square/Utils/showSnackBar.dart';
import 'package:info_tax_square/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();
  RegisterApi? registerApi;
  var isLoading = false.obs;
  SharedPreferences? preferences;

  login({email, password, context}) async {
    try {
      isLoading(true);
      var body = await registerApi!.login(email: email, password: password);
      print(body);
      var data = jsonDecode(body);
      if (data["message"] == "Login successfuly.") {
        preferences = await SharedPreferences.getInstance();
        preferences!.setString(User_Id, data["userid"]);

        var deviceId = await messaging.getToken();
        print("deviceId $deviceId ");
        var sendId = await Api().updateDeviceId(deviceId);
        var json = jsonDecode(sendId);
        print(json["message"]);
        Get.offAll(()=>HomePage());
        print(data["userid"]);
      }
      showSnackBar(data["message"], context);
      print(body);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
  signup({email, password, context}) async {
    try {
      isLoading(true);
      var body =
          await registerApi!.signup(email: email, password: password);
      print(body);
      var data = jsonDecode(body);
      if (data["message"] == "signup successfuly.") {
        showSnackBar("Singup Succefully please login to continue", context);
        Get.offAll(()=>LoginScreen());
      }
      showSnackBar(data["message"], context);

      print(body);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
  forgotPassword({email, context}) async{
    var sendPassword = '';
    try{
      isLoading(true);
      var body = await registerApi!.getPassword(email: email);
      var data = jsonDecode(body);
      print(data);
      if(data["status"]){
        sendPassword = data["password"];
        showSnackBar(data["message"], context);
        print(data["data"]);
      }
    }
    catch(e){
      print(e);
    }
    finally{
      isLoading(false);
    }
  }
  changePassword({currentPassword, newPassword, context}) async{
    try{
      isLoading(true);
      var body = await registerApi!.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword
      );
      var data = jsonDecode(body);
      print(data);
      showSnackBar(data["message"], context);
    }
    catch(e){
      print(e);
    }
    finally{
      isLoading(false);
    }
  }

  logout() async {
    preferences = await SharedPreferences.getInstance();
    preferences!.remove(User_Id).then((value) => Get.offAll(()=>LoginScreen()));
  }

  @override
  void onInit() {
    registerApi = RegisterApi();
    super.onInit();
  }

}
