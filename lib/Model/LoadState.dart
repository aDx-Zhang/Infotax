

import 'dart:convert';

LoadState loadStateFromJson(String str) => LoadState.fromJson(json.decode(str));

String loadStateToJson(LoadState data) => json.encode(data.toJson());

class LoadState {
  LoadState({
    required this.id,
    required this.stname,
  });

  String id;
  String stname;

  factory LoadState.fromJson(Map<String, dynamic> json) => LoadState(
    id: json["id"]?? "",
    stname: json["stname"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stname": stname,
  };
}
