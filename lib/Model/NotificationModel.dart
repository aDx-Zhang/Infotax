import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

List<NotificationModel> allNotificationFromJson(String value) =>
    List<NotificationModel>.from(jsonDecode(value)["data"]
        .map((service) => NotificationModel.fromJson(service)));

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.detail,
    required this.date,
  });

  String title;
  String detail;
  String date;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"] ?? "",
        detail: json["Detail"] ?? "",
        date: json["date"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "Detail": detail,
        "date": date,
      };
}
