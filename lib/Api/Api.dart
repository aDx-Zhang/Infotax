import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:info_tax_square/Model/UserProfile.dart';
import 'package:info_tax_square/Utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const String Base_Url = 'https://infotaxsquare.com/api';
  static const String Index_Url = '/index.php';
  static const String All_Services_Url = '/allservices.php';
  static const String Secretary_States_Url = '/secretary-states.php';
  static const String Secretary_States_Detail_Url = '/secretary_state_detail.php';
  static const String Article_Categories_Url = '/article-categories.php';
  static const String Article_Categories_List_Url = '/article-cat-list.php';
  static const String Article_Detail_Url = '/article_detail.php';
  static const String User_Profile_View_Url = "/user_profile_view.php";
  static const String Update_User_Profile_Url = "/update_profile.php";
  static const String Load_States_Url = "/load_states.php";
  static const String Notifications_Url = "/notifications.php";
  static const String Inquiry_Url = "/inquiry.php";
  static const String Chat_Url = "/chat.php";
  static const String Chat_History_Url = "/chathistory.php";
  static const String Download_Doc = "/download_doc.php";
  static const String Download_Form = "/download_forms.php";
  static const String Upload_Doc = "/uploaddoc.php";
  static const String My_Upload_Doc = "/myupload_doc.php";
  static const String deviceId = "/getdeviceid.php";

  getIndex() async {
    var response = await http.get(Uri.parse(Base_Url + Index_Url));
    return response.body;
  }

  getAllServices() async {
    var response = await http.get(Uri.parse(Base_Url + All_Services_Url));
    return response.body;
  }

  getSecretaryState() async {
    var response = await http.get(Uri.parse(Base_Url + Secretary_States_Url));
    return response.body;
  }

  getSecretaryStateDetail({state_id}) async {
    var data = {
      "state_id" : state_id
    };
    var response = await http.post(
        Uri.parse(Base_Url+Secretary_States_Detail_Url), body: jsonEncode(data));
    return response.body;
  }

  getArticleCategories() async {
    var response = await http.get(Uri.parse(Base_Url + Article_Categories_Url));
    return response.body;
  }

  getArticleCategoriesList({cat_id}) async {
    var data = {"cat_id": cat_id};
    var response = await http.post(
        Uri.parse(Base_Url + Article_Categories_List_Url),
        body: jsonEncode(data));
    return response.body;
  }

  getArticleDetail({article_id}) async {
    var data = {"article_id": article_id};
    var response = await http.post(Uri.parse(Base_Url + Article_Detail_Url),
        body: jsonEncode(data));
    return response.body;
  }

  getUserProfileData() async {
    var id = await getUserId();
    var data = {"userid": id};
    var response = await http.post(
        Uri.parse(Base_Url + User_Profile_View_Url), body: jsonEncode(data));
    return response.body;
  }

  updateUserProfile(UserProfile userProfile) async {
    var id = await getUserId();
    var usersData = {
      "userid": id,
      "sec_email":userProfile.secEmail,
      "companyname":userProfile.companyname,
      "firstname":userProfile.firstname,
      "lastname":userProfile.lastname,
      "address":userProfile.address,
      "city":userProfile.city,
      "state":userProfile.state,
      "zipcode":userProfile.zipcode,
      "phone":userProfile.phone,
      "phone1":userProfile.phone1,
      "phone2":userProfile.phone2,
      "fax":userProfile.fax,
      "fax1":userProfile.fax1,
      "fax2":userProfile.fax2
    };

    var response = await http.post(
        Uri.parse(Base_Url + Update_User_Profile_Url),
        body: jsonEncode(usersData));
    return response.body;
  }

  getLoadStates() async {
    var response = await http.get(Uri.parse(Base_Url + Load_States_Url));
    return response.body;
  }

  getNotification() async {
    var response = await http.get(Uri.parse(Base_Url + Notifications_Url));
    return response.body;
  }

  sendInquiry({full_name, email_id, phone_no, comments}) async {
    var data = {
      "full_name": full_name,
      "email_id": email_id,
      "phone_no": phone_no,
      "comments": comments
    };
    var response = await http.post(Uri.parse(Base_Url + Inquiry_Url),
        body: data);
    return response.body;
  }

  getChatsHistory() async{
    var userId = await getUserId();
    var data = {
      "uid":userId
    };
    var response = await http.post(Uri.parse(Base_Url + Chat_History_Url), body: data);
    return response.body;
  }
  sendChat({message}) async{
    var userId = await getUserId();
    var data = {
      "uid":userId,
      "message":message
    };
    var response = await http.post(Uri.parse(Base_Url + Chat_Url), body: data);
    return response.body;
  }

  getDownloadDoc() async {
    var userId = await getUserId();
    var response = await http.post(
        Uri.parse(Base_Url + Download_Doc),
      body: {"uid" : userId}
    );
    return response.body;
  }
  uploadDoc(document) async {

    var userId = await getUserId();
    var data = {
      "uid" : userId,
      "doc_name":"SALES REPORT",
      "file_name":document
    };
    var response = await http.post(
        Uri.parse(Base_Url + Upload_Doc),
        body: jsonEncode(data)
    );
    return response.body;
  }
  getMyUploadDoc() async {
    var userId = await getUserId();
    var data =  {
      "uid" : userId
    };
    var response = await http.post(
      Uri.parse(Base_Url + My_Upload_Doc),
      body: data
    );
    print("uplaoded docs" + response.body);
    return response.body;
  }
  getDownloadedForm() async {
    var response = await http.get(
        Uri.parse(Base_Url + Download_Form),
    );
    print("download forms" + response.body);
    return response.body;
  }
  updateDeviceId(device_id) async{
    var userId = await getUserId();
    var data = {
        "device_id" : device_id,
        "device_type" : "android",
        "uid" : userId
    };
    var response = await http.post(Uri.parse(Base_Url + deviceId), body: data);
    return response.body;
  }


}
getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var user = preferences.getString(User_Id);
  print(user);
  return user;
  // return "10277";
}