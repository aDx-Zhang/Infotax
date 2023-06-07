

import 'dart:convert';

DownloadForm downloadFormFromJson(String str) => DownloadForm.fromJson(json.decode(str));

String downloadFormToJson(DownloadForm data) => json.encode(data.toJson());

List<DownloadForm> allDownloadFormFromJson(String value) => List<DownloadForm>.from(
    jsonDecode(value)["data"].map((service) => DownloadForm.fromJson(service))
);

class DownloadForm {
  DownloadForm({
    required this.title,
    required this.downloadUrl,
    required this.orderNowUrl,
    required this.moreInfoUrl,
  });

  String title;
  String downloadUrl;
  String orderNowUrl;
  String moreInfoUrl;

  factory DownloadForm.fromJson(Map<String, dynamic> json) => DownloadForm(
    title: json["title"]?? "",
    downloadUrl: json["download_url"]?? "",
    orderNowUrl: json["order_now_url"]?? "",
    moreInfoUrl: json["more_info_url"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "download_url": downloadUrl,
    "order_now_url": orderNowUrl,
    "more_info_url": moreInfoUrl,
  };
}