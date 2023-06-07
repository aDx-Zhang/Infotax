import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Api/Api.dart';
import 'package:info_tax_square/Model/ArticleDetail.dart';
import 'package:info_tax_square/Screen/Inquiry/InquiryScreen.dart';
import 'package:info_tax_square/Utils/BottomSendInquiryButton.dart';
import 'package:info_tax_square/Utils/Colors.dart';

class ArticleCategoryDetailScreen extends StatefulWidget {
  ArticleCategoryDetailScreen({Key? key, this.article_id}) : super(key: key);
  var article_id;

  @override
  State<ArticleCategoryDetailScreen> createState() =>
      _ArticleCategoryDetailScreenState();
}

class _ArticleCategoryDetailScreenState
    extends State<ArticleCategoryDetailScreen> {
  var check = false;
  String? htmlData;
  late ArticleDetail articleDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondary,
        title: Text(
          "Detail",
          style: TextStyle(color: AppColors.colorBackground, fontSize: 22),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.colorBackground,
              size: 22,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<ArticleDetail>(
                future: getArticleDetail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            articleDetail.title,
                            style: TextStyle(
                                color: AppColors.colorSecondary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Text(
                            articleDetail.summary,
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(height: 10),
                          Html(data: articleDetail.article)
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
      bottomNavigationBar: BottomSendInquiryButton(
        // onTap: (){
        //   Get.to(()=>InquiryScreen());
        // },
        text: "Inquiry",
      ),
    );
  }

  Future<ArticleDetail> getArticleDetail() async {
    try {
      var response =
          await Api().getArticleDetail(article_id: widget.article_id);
      var data = jsonDecode(response);
      print(data);
      if (data["status"]) {
        articleDetail = ArticleDetail.fromJson(data["data"][0]);
        // htmlData = data["data"][0].toString();
        //  print("htmlData $htmlData");
      }
    } catch (e) {
      print(e);
    } finally {}
    return articleDetail;
  }

  @override
  void initState() {
    super.initState();
    getArticleDetail();
  }
}
