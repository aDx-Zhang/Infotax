import 'dart:convert';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
     this.uname,
     this.secEmail,
     this.companyname,
     this.firstname,
     this.lastname,
     this.address,
     this.city,
     this.state,
     this.zipcode,
     this.phone,
     this.phone1,
     this.phone2,
     this.fax,
     this.fax1,
     this.fax2,
  });

  String? uname;
  String? secEmail;
  String? companyname;
  String? firstname;
  String? lastname;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? phone;
  String? phone1;
  String? phone2;
  String? fax;
  String? fax1;
  String? fax2;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        uname: json["uname"] ?? "",
        secEmail: json["sec_email"] ?? "",
        companyname: json["companyname"] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        address: json["address"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        zipcode: json["zipcode"] ?? "",
        phone: json["phone"] ?? "",
        phone1: json["phone1"] ?? "",
        phone2: json["phone2"] ?? "",
        fax: json["fax"] ?? "",
        fax1: json["fax1"] ?? "",
        fax2: json["fax2"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "uname": uname,
        "sec_email": secEmail,
        "companyname": companyname,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "phone": phone,
        "phone1": phone1,
        "phone2": phone2,
        "fax": fax,
        "fax1": fax1,
        "fax2": fax2,
      };
}
