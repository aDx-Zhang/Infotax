

import 'dart:convert';

ArticleDetail articleDetailFromJson(String str) => ArticleDetail.fromJson(json.decode(str));

String articleDetailToJson(ArticleDetail data) => json.encode(data.toJson());

class ArticleDetail {
  ArticleDetail({
    required this.title,
    required this.summary,
    required this.article,
  });

  String title;
  String summary;
  String article;

  factory ArticleDetail.fromJson(Map<String, dynamic> json) => ArticleDetail(
    title: json["title"]?? "",
    summary: json["summary"]?? "",
    article: json["article"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "summary": summary,
    "article": article,
  };
}