

import 'dart:convert';

DownloadDoc downloadDocFromJson(String str) => DownloadDoc.fromJson(json.decode(str));

String downloadDocToJson(DownloadDoc data) => json.encode(data.toJson());

List<DownloadDoc> allDownloadDocFromJson(String value) => List<DownloadDoc>.from(
    jsonDecode(value)["data"].map((service) => DownloadDoc.fromJson(service))
);

class DownloadDoc {
  DownloadDoc({
    required this.tableDescription,
    required this.orderid,
    required this.docName,
    required this.docId,
    required this.feeDate,
    required this.downloadDate,
    required this.ddate,
    required this.fileUrl,
  });

  String tableDescription;
  String orderid;
  String docName;
  String docId;
  String feeDate;
  String downloadDate;
  String ddate;
  String fileUrl;

  factory DownloadDoc.fromJson(Map<String, dynamic> json) => DownloadDoc(
    tableDescription: json["table_description"] ?? "",
    orderid: json["orderid"]?? "",
    docName: json["doc_name"]?? "",
    docId: json["doc_id"]?? "",
    feeDate: json["fee_date"]?? "",
    downloadDate: json["download_date"]?? "",
    ddate: json["ddate"]?? "",
    fileUrl: json["file_url"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "table_description": tableDescription,
    "orderid": orderid,
    "doc_name": docName,
    "doc_id": docId,
    "fee_date": feeDate,
    "download_date": downloadDate,
    "ddate": ddate,
    "file_url": fileUrl,
  };
}