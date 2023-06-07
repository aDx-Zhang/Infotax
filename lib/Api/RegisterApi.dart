
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:info_tax_square/Api/Api.dart';

class RegisterApi{
  static const String Base_Url = 'https://infotaxsquare.com/api';
  static const String Login_Url = '/login.php';
  static const String Signup_Url = '/signup.php';
  static const String Change_Password_Url = '/changePassword.php';
  static const String Get_Password_Url = '/getPassword.php';

  Map<String, String> requestHeaders = {
    "Access-Control-Allow-Origin": "*",
    'Accept': 'application/json',
  };

  Future login({email, password}) async{
    var data = {
      "uname": email,
      "pswd": password
    };
    var response = await http.post(Uri.parse(Base_Url + Login_Url), body: jsonEncode(data), );
    return response.body;
  }
  Future signup({email, password}) async{
    var data = {
      "uname": email,
      "pswd": password
    };
    var response = await http.post(Uri.parse(Base_Url + Signup_Url), body: jsonEncode(data),);
    return response.body;
  }
  Future changePassword({currentPassword, newPassword}) async{
    var id = await getUserId();
    var data = {
      "userid": id,
      "currpassword" : currentPassword,
      "newpassword" : newPassword
    };
    var response = await http.post(Uri.parse(Base_Url + Change_Password_Url), body: data);
    print(response.body);
    return response.body;
  }
  Future getPassword({email}) async{
    var data = {
      "email_address": email,
    };
    var response = await http.post(Uri.parse(Base_Url + Get_Password_Url), body: data);
    return response.body;
  }
}