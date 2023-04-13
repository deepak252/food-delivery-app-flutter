

import 'package:food_delivery_app/models/address.dart';

class User {
  final int userId;
  String? fullName;
  String? email;
  String? mobile;
  String? profilePic;
  
  User({
    required this.userId,
    this.fullName,
    this.email,
    this.mobile,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    fullName: json["fullName"],
    email: json["email"],
    mobile: json["mobile"],
    profilePic: json["profilePic"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullName": fullName,
    "email": email,
    "mobile": mobile,
    "profilePic": profilePic,
  };

  User copyWith({
    int? userId,
    String? token,
    String? fullName,
    String? email,
    String? mobile,
    String? profilePic,
    String? fcmToken,
    Address? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}



// import 'dart:convert';

// import 'package:food_delivery_app/models/address.dart';

// class User {
//   final int userId;
//   String? token;
//   String? fullName;
//   String? email;
//   String? mobile;
//   String? profilePic;
//   String? fcmToken;
//   Address? address;
//   String? favPetIds;
//   List<int>? adoptPetIds;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   bool isLive=false;
  
//   User({
//     required this.userId,
//     this.token,
//     this.fullName,
//     this.email,
//     this.mobile,
//     this.profilePic,
//     this.fcmToken,
//     this.address,
//     this.favPetIds,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//     userId: json["userId"],
//     token: json["token"],
//     fullName: json["fullName"],
//     email: json["email"],
//     mobile: json["mobile"],
//     profilePic: json["profilePic"],
//     fcmToken: json["fcmToken"],
//     address: json["address"]!=null 
//     ? Address.fromJson(jsonDecode(json["address"]))
//     : null,
//     favPetIds: json["favouritePetsId"],
//     createdAt: DateTime.tryParse(json["createdAt"]??''),
//     updatedAt: DateTime.tryParse(json["updatedAt"]??''),
//   );

//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "token": token,
//     "fullName": fullName,
//     "email": email,
//     "mobile": mobile,
//     "profilePic": profilePic,
//     "fcmToken": fcmToken,
//     "address": address?.toJson(),
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//   };

//   User copyWith({
//     int? userId,
//     String? token,
//     String? fullName,
//     String? email,
//     String? mobile,
//     String? profilePic,
//     String? fcmToken,
//     Address? address,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) {
//     return User(
//       userId: userId ?? this.userId,
//       token: token ?? this.token,
//       fullName: fullName ?? this.fullName,
//       email: email ?? this.email,
//       mobile: mobile ?? this.mobile,
//       profilePic: profilePic ?? this.profilePic,
//       fcmToken: fcmToken ?? this.fcmToken,
//       address: address ?? this.address,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }
