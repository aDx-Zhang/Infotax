import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Controllers/ApiController.dart';
import 'package:info_tax_square/Model/ArticleCatList.dart';
import 'package:info_tax_square/Screen/Category/ArticleCategoryDetailScreen.dart';
import 'package:info_tax_square/Screen/Category/components/CategoryCardDesign.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class ArticleCategoryListScreen extends StatefulWidget {
  ArticleCategoryListScreen({Key? key, this.catList}) : super(key: key);
  String? catList;

  @override
  State<ArticleCategoryListScreen> createState() =>
      _ArticleCategoryListScreenState();
}

class _ArticleCategoryListScreenState extends State<ArticleCategoryListScreen> {
  // var controller = Get.put(ApiController());

  List<ArticleCatList> articlesCatList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        title: Text("Article", style: TextStyle(color: AppColors.colorBackground, fontSize: 22),),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back, color: AppColors.colorBackground, size: 22,)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ArticleCatList>>(
        future: getListData(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: articlesCatList.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var categoryList = articlesCatList[index];
                    return CategoryCardDesign(
                      title: categoryList.title,
                      url: categoryList.titleUrl,
                      id: categoryList.articleId,
                      onTap: (){
                        Get.to(()=>ArticleCategoryDetailScreen(
                          article_id: categoryList.articleId,
                        ));
                      },
                    );
                  }),
            );
          }

          else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.colorSecondary,
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<ArticleCatList>> getListData() async {
    try{
      var response = await Api().getArticleCategoriesList(cat_id: widget.catList);
      if(response != null){
        print(response);
        articlesCatList.addAll(allArticleCategoryListFromJson(response));
      }
    }
    catch(e){
      print(e);
    }
    finally{}
    return articlesCatList;
  //  return articlesCatList;
    // articlesCatList.addAll(controller.getArticlesCategoryList(catList: widget.catList!));
  }

  @override
  void initState() {
    super.initState();
   // getListData();
  }

  @override
  void dispose() {
    super.dispose();
    articlesCatList.clear();
  }
}
