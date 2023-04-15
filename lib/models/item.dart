

import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/utils/num_utils.dart';

class Item {
  String id;
  String? name;
  ///Restaurant Name
  String? resName;
  List<String> category;
  List<String> images;
  String? descEnglish;
  String? descHindi;
  double? price;
  List<ItemReview> reviews;
  Address? location;
  int? stock;
  
  Item({
    required this.id,
    this.name,
    this.resName,
    this.category =const [],
    this.images=const [],
    this.descEnglish,
    this.descHindi,
    this.price,
    this.reviews= const [],
    this.location,
    this.stock=0
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"]??'',
    name: json["name"],
    resName: json["resName"],
    category: json["category"] != null
            ? List<String>.from(json["category"].map((x) => x.toString()))
            : [],
    descEnglish: json["descEnglish"],
    descHindi: json["descHindi"],
    price: NumUtils.parseDouble(json["price"]),
    images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x.toString()))
            : [],
    reviews: json["reviews"] != null
            ? List<ItemReview>.from(json["reviews"].map((x) => x))
            : [],
    location: Address.fromJson(json["location"]),
    stock: json["stock"],
    
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "resName": resName,
    "category": List<String>.from(category.map((x) => x)),
    "images": List<String>.from(images.map((x) => x)),
    "descEnglish": descEnglish,
    "descHindi": descHindi,
    "price": price,
    "reviews": List<ItemReview>.from(reviews.map((x) => x)),
    "location": location?.toJson(),
    "stock" : stock
  };
}

class ItemReview {
    ItemReview({
      required this.userName,
      required this.profilePic,
      required this.rating,
      required this.comment,
    });

    String userName;
    String? profilePic;
    int rating;
    String comment;

    factory ItemReview.fromJson(Map<String, dynamic> json) => ItemReview(
        userName: json["name"],
        profilePic: json["profilePic"],
        rating: json["rating"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "name": userName,
        "profilePic": profilePic,
        "rating": rating,
        "comment": comment,
    };
}

extension ExtItem on Item{
  double get rating{
    return reviews.fold(0,(value, element) => value +element.rating);
  }
}