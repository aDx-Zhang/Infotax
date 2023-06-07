

import 'dart:convert';

AllService allServiceFromJson(String str) => AllService.fromJson(json.decode(str));

String allServiceToJson(AllService data) => json.encode(data.toJson());

List<AllService> allServicesListFromJson(String value) => List<AllService>.from(
  jsonDecode(value)["data"].map((service) => AllService.fromJson(service))
);

class AllService {
  AllService({
    required this.csTitle,
    required this.csPageUrl,
  });

  String csTitle;
  String csPageUrl;

  factory AllService.fromJson(Map<String, dynamic> json) => AllService(
    csTitle: json["cs_title"] ?? "",
    csPageUrl: json["cs_page_url"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "cs_title": csTitle,
    "cs_page_url": csPageUrl,
  };
}