

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

List<Chat> chatsListFromJson(String value) => List<Chat>.from(
    jsonDecode(value)["data"].map((chat) => Chat.fromJson(chat)),
  growable: true
);

class Chat {
  Chat({
    required this.message,
    required this.msgDate,
    required this.sentBy,
  });

  String? message;
  String? msgDate;
  String? sentBy;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    message: json["message"] ?? "",
    msgDate: json["msg_date"]?? "",
    sentBy: json["sent_by"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "msg_date": msgDate,
    "sent_by": sentBy,
  };
}