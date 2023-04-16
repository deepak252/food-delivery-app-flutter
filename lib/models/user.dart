

import 'package:food_delivery_app/models/cart_item.dart';

class User {
  final String id;
  String? fullName;
  String? email;
  String? phone;
  String? profilePic;
  List<String> favItems;
  List<CartItem> cartItems;
  
  User({
    required this.id,
    this.fullName,
    this.email,
    this.phone,
    this.profilePic,
    this.favItems = const [],
    this.cartItems =  const []
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phone: json["phone"],
    profilePic: json["profilePic"],
    favItems: json["favItems"] != null
      ? List<String>.from(json["favItems"].map((x) => x))
      : [],
    cartItems: json["cartItems"] != null
      ? List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x)))
      : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phone": phone,
    "profilePic": profilePic,
    "favItems": List<String>.from(favItems.map((x) => x)),
    "cartItems": List<CartItem>.from(cartItems.map((x) => x.toJson())),
  };

  // User copyWith({
  //   String? id,
  //   String? token,
  //   String? fullName,
  //   String? email,
  //   String? phone,
  //   String? profilePic,
  //   String? fcmToken,
  //   Address? address,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return User(
  //     id: id ?? this.id,
  //     fullName: fullName ?? this.fullName,
  //     email: email ?? this.email,
  //     phone: phone ?? this.phone,
  //     profilePic: profilePic ?? this.profilePic,
  //   );
  // }
}


