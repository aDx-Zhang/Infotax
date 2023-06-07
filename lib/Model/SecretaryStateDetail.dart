

import 'dart:convert';

SecretaryStateDetail secretaryStateDetailFromJson(String str) => SecretaryStateDetail.fromJson(json.decode(str));

String secretaryStateDetailToJson(SecretaryStateDetail data) => json.encode(data.toJson());

class SecretaryStateDetail {
  SecretaryStateDetail({
    required this.stateId,
    required this.ssTitle,
    required this.fnStripTagsSsPageContent,
  });

  String stateId;
  String ssTitle;
  String fnStripTagsSsPageContent;

  factory SecretaryStateDetail.fromJson(Map<String, dynamic> json) => SecretaryStateDetail(
    stateId: json["state_id"]?? "",
    ssTitle: json["ss_title"]?? "",
    fnStripTagsSsPageContent: json["fnStripTags(ss_page_content)"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "ss_title": ssTitle,
    "fnStripTags(ss_page_content)": fnStripTagsSsPageContent,
  };
}