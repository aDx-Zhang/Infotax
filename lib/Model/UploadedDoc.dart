

import 'dart:convert';

UploadedDoc uploadedDocFromJson(String str) => UploadedDoc.fromJson(json.decode(str));

String uploadedDocToJson(UploadedDoc data) => json.encode(data.toJson());

List<UploadedDoc> allUploadedDocsFromJson(String value) => List<UploadedDoc>.from(
    jsonDecode(value)["data"].map((service) => UploadedDoc.fromJson(service))
);

class UploadedDoc {
  UploadedDoc({
    required this.docName,
    required this.docId,
    required this.fileUrl,
  });

  String docName;
  String docId;
  String fileUrl;

  factory UploadedDoc.fromJson(Map<String, dynamic> json) => UploadedDoc(
    docName: json["doc_name"]?? "",
    docId: json["doc_id"]?? "",
    fileUrl: json["file_url"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "doc_name": docName,
    "doc_id": docId,
    "file_url": fileUrl,
  };
}