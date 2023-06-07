

import 'dart:convert';

SecretaryState secretaryStateFromJson(String str) => SecretaryState.fromJson(json.decode(str));

String secretaryStateToJson(SecretaryState data) => json.encode(data.toJson());

List<SecretaryState> allSecretaryStateListFromJson(String value) => List<SecretaryState>.from(
    jsonDecode(value)["data"].map((service) => SecretaryState.fromJson(service))
);

class SecretaryState {
  SecretaryState({
    required this.stateId,
    required this.stname,
    required this.ssPageUrl,
    required this.totalServices,
  });

  String stateId;
  String stname;
  String ssPageUrl;
  String totalServices;

  factory SecretaryState.fromJson(Map<String, dynamic> json) => SecretaryState(
    stateId: json["state_id"]?? "",
    stname: json["stname"]?? "",
    ssPageUrl: json["ss_page_url"]?? "",
    totalServices: json["Total_services"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "stname": stname,
    "ss_page_url": ssPageUrl,
    "Total_services": totalServices,
  };
}