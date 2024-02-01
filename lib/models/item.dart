

import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/utils/date_time_utils.dart';
import 'package:food_delivery_app/utils/num_utils.dart';

class Item {
  String id;
  String? name;
  ///Restaurant Name
  String? restaurantName;
  List<String> category;
  List<String> images;
  String? descEnglish;
  String? descHindi;
  double price;
  List<ItemReview> reviews;
  Address? restaurantLocation;
  int? stock;
  
  Item({
    required this.id,
    this.name,
    this.restaurantName,
    this.restaurantLocation,
    this.category =const [],
    this.images=const [],
    this.descEnglish,
    this.descHindi,
    required this.price,
    this.reviews= const [],
    this.stock=0
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"]??'',
    name: json["name"],
    restaurantName: json["restaurantName"],
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
            ? List<ItemReview>.from(json["reviews"].map((x) => ItemReview.fromJson(x)))
            : [],
    restaurantLocation: Address.fromJson(json["restaurantLocation"]),
    stock: json["stock"],
    
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "restaurantName": restaurantName,
    "category": List<String>.from(category.map((x) => x)),
    "images": List<String>.from(images.map((x) => x)),
    "descEnglish": descEnglish,
    "descHindi": descHindi,
    "price": price,
    "reviews": List.from(reviews.map((x) => x.toJson())),
    "restaurantLocation": restaurantLocation?.toJson(),
    "stock" : stock
  };
}

class ItemReview {
    ItemReview({
      required this.user,
      required this.rating,
      required this.comment,
      required this.createdAt
    });

    User user;
    int rating;
    String comment;
    DateTime createdAt;

    factory ItemReview.fromJson(Map<String, dynamic> json) => ItemReview(
        user: User.fromJson(json["user"]),
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]??'').toLocal(),
    );

    Map<String, dynamic> toJson() => {
        "user" : user.toJson(),
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
    };
}

extension ExtItem on Item{
  double get rating{
    if(reviews.isEmpty){
      return 0;
    }
    final r = reviews.fold(0,(value, element) => value +element.rating)/reviews.length;
    return NumUtils.parseDouble(r,precision: 1);
  }
  
}


extension ExtItemReview on ItemReview{
 
  String get date{
    String d = DateTimeUtils.formatMMMDDYYYY(createdAt);
    String cd = DateTimeUtils.formatMMMDDYYYY(DateTime.now());
    if(d==cd){
      return "Today";
    }
    return d;
  }
  String get time{
    return DateTimeUtils.formatHHMM(createdAt);
  }
  
}