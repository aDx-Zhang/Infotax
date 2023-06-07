

import 'dart:convert';

ArticleCatList articleCatListFromJson(String str) => ArticleCatList.fromJson(json.decode(str));

String articleCatListToJson(ArticleCatList data) => json.encode(data.toJson());

List<ArticleCatList> allArticleCategoryListFromJson(String value) => List<ArticleCatList>.from(
    jsonDecode(value)["data"].map((service) => ArticleCatList.fromJson(service))
);

class ArticleCatList {
  ArticleCatList({
    required this.articleId,
    required this.title,
    required this.titleUrl,
  });

  String articleId;
  String title;
  String titleUrl;

  factory ArticleCatList.fromJson(Map<String, dynamic> json) => ArticleCatList(
    articleId: json["article_id"] ?? "",
    title: json["title"]?? "",
    titleUrl: json["title_url"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "article_id": articleId,
    "title": title,
    "title_url": titleUrl,
  };
}