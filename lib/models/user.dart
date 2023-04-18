

import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/cart_item.dart';

class User {
  final String id;
  String? fullName;
  String? email;
  String? phone;
  String? profilePic;
  Address? address;
  List<String> favItems;
  List<CartItem> cartItems;
  
  User({
    required this.id,
    this.fullName,
    this.email,
    this.phone,
    this.profilePic,
    this.address,
    this.favItems = const [],
    this.cartItems =  const []
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phone: json["phone"],
    profilePic: json["profilePic"],
    address: json["address"]!=null
     ? Address.fromJson(json["address"])
     : null,
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
    "address": address?.toJson(),
    "favItems": List.from(favItems.map((x) => x)),
    "cartItems": List.from(cartItems.map((x) => x.toJson())),
  };

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? profilePic,
    Address? address,
    List<String>? favItems,
    List<CartItem>? cartItems,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePic: profilePic ?? this.profilePic,
      address: address ?? this.address,
      favItems: favItems ?? this.favItems,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}


