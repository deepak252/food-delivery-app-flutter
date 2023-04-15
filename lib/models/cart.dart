import 'package:food_delivery_app/models/item.dart';

class Cart{
  // final String id;
  String? itemId;
  Item? item;
  int? quantity;

  Cart({
    // required this.id,
    required this.itemId,
    required this.item,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    itemId: json["itemId"],
    item: json["item"]!=null 
      ? Item.fromJson(json["item"])
      : null,
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    // "_id": id,
    "itemId" : itemId,
    "item": item?.toJson(),
    "quantity": quantity,
  };
}