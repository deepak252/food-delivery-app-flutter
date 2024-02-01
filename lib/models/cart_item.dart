import 'package:food_delivery_app/models/item.dart';

class CartItem{
  String itemId;
  Item? item;
  int? quantity;

  CartItem({
    required this.itemId,
    this.item,
    this.quantity=1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: json["itemId"],
    item: json["item"]!=null 
      ? Item.fromJson(json["item"])
      : null,
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson(){
    if(item!=null){
      return {
        "itemId" : itemId,
        "item": item?.toJson(),
        "quantity": quantity,
      };
    }
    return {
      "itemId" : itemId,
      "quantity": quantity,
    };
  }
}