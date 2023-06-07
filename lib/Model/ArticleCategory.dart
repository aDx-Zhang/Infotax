

import 'dart:convert';

ArticleCategory articleCategoryFromJson(String str) => ArticleCategory.fromJson(json.decode(str));

String articleCategoryToJson(ArticleCategory data) => json.encode(data.toJson());

List<ArticleCategory> allArticleCategoryFromJson(String value) => List<ArticleCategory>.from(
    jsonDecode(value)["data"].map((service) => ArticleCategory.fromJson(service))
);

class ArticleCategory {
  ArticleCategory({
    required this.catId,
    required this.catName,
    required this.catNameUrl,
  });

  String catId;
  String catName;
  String catNameUrl;

  factory ArticleCategory.fromJson(Map<String, dynamic> json) => ArticleCategory(
    catId: json["cat_id"] ?? "",
    catName: json["cat_name"]?? "",
    catNameUrl: json["cat_name_url"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "cat_id": catId,
    "cat_name": catName,
    "cat_name_url": catNameUrl,
  };
}