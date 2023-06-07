import 'dart:convert';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Model/AllService.dart';
import 'package:info_tax_square/Model/ArticleCatList.dart';
import 'package:info_tax_square/Model/ArticleCategory.dart';
import 'package:info_tax_square/Model/DownloadDoc.dart';
import 'package:info_tax_square/Model/SecretaryState.dart';
import 'package:info_tax_square/Model/UserProfile.dart';
import 'package:info_tax_square/Utils/AppUtils.dart';

class ApiController extends GetxController {
  static ApiController instance = Get.find();

  var indexData = "".obs;
  var isIndexLoaded = false.obs;

  var isServicesLoaded = false.obs;
  RxList<AllService> allServices = <AllService>[].obs;
  RxList<AllService> filterAllServices = <AllService>[].obs;

  var isSecretaryStatesLoaded = false.obs;
  RxList<SecretaryState> secretaryStates = <SecretaryState>[].obs;
  RxList<SecretaryState> filteredSecretaryStates = <SecretaryState>[].obs;

  var isArticlesCategoriesLoaded = false.obs;
  RxList<ArticleCategory> articlesCategories = <ArticleCategory>[].obs;
  RxList<ArticleCategory> filterArticlesCategories = <ArticleCategory>[].obs;

  var isArticlesCategoryListLoaded = false.obs;


  var isProfileLoaded = false.obs;
  var userProfile = UserProfile().obs;

  getIndex() async {
    try {
      isIndexLoaded(true);
      var response = await Api().getIndex();
      var data = jsonDecode(response);
      //   print(data["status"]);
      if (data["status"]) {
        var find1 = "{description1_new:";
        var find2 = "}";
        final new1 = data["data"][0].toString().replaceAll(find1, "");
        final new2 = new1.replaceAll(find2, "");

        indexData.value = new2;
        // indexData.value = data["data"][0].toString();
        // print(indexData);
      }
    } catch (e) {
      print(e);
    } finally {
      isIndexLoaded(false);
    }
  }

  getAllServices() async {
    try {
      isServicesLoaded(true);
      var response = await Api().getAllServices();
      if (response != null) {
        allServices.assignAll(allServicesListFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isServicesLoaded(false);
    }
    update();
  }
  getFilteredAllServices(text) async{
    filterAllServices.assignAll(allServices
        .where((service) =>
        equalsIgnoreCase(service.csTitle).contains(equalsIgnoreCase(text)))
        .toList());
    update();
    print(filterAllServices);
    return filterAllServices.length;
  }

  getSecretaryStates() async {
    try {
      isSecretaryStatesLoaded(true);
      var response = await Api().getSecretaryState();
      if (response != null) {
        secretaryStates.assignAll(allSecretaryStateListFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isSecretaryStatesLoaded(false);
    }
    update();
  }
  getFilteredSecretaryStated(text) {
    filteredSecretaryStates.assignAll(secretaryStates
        .where((state) =>
            equalsIgnoreCase(state.stname).contains(equalsIgnoreCase(text)))
        .toList());
    update();
    print(filteredSecretaryStates);
    return filteredSecretaryStates.length;
  }

  getArticlesCategories() async {
    try {
      isArticlesCategoriesLoaded(true);
      var response = await Api().getArticleCategories();
      if (response != null) {
        articlesCategories.assignAll(allArticleCategoryFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isArticlesCategoriesLoaded(false);
    }
    update();
  }
  getFilteredArticlesCategories(text) async{
    filterArticlesCategories.assignAll(articlesCategories
        .where((service) =>
        equalsIgnoreCase(service.catName).contains(equalsIgnoreCase(text)))
        .toList());
    update();
    print(filterArticlesCategories);
    return filterArticlesCategories.length;
  }

  getArticlesCategoryList({catList}) async {
    List<ArticleCatList> articlesCategoryList = [];
    try {
      isArticlesCategoryListLoaded(true);
      var response = await Api().getArticleCategoriesList(cat_id: catList);
      if (response != null) {
        articlesCategoryList.addAll(allArticleCategoryListFromJson(response));
      }
    } catch (e) {
      print(e);
    } finally {
      isArticlesCategoryListLoaded(false);
    }
    update();
    return articlesCategoryList;
  }

  getUserProfile() async {
    try {
      isProfileLoaded(true);
      var response = await Api().getUserProfileData();
      var data = jsonDecode(response);
      print(data.toString());
      if (data["result"] == "found") {
        print(data.toString());
        userProfile.value = UserProfile.fromJson(data["data"][0]);
      }
    } catch (e) {
      print(e);
    } finally {
      isProfileLoaded(false);
    }
    update();
  }



  @override
  void onInit() {
    super.onInit();
    getIndex();
    getAllServices();
    getSecretaryStates();
    getArticlesCategories();
    getArticlesCategoryList();
    getUserProfile();
  }
}
