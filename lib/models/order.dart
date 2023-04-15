
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/models/user.dart';

class Order {
    Order({
      required this.id,
      required this.user,
      required this.item,
      required this.orderPrice,  
      required this.deliveryAddress,
      this.quantity,
      this.status,
      this.isCod,
      this.deliveryDate,
      this.createdAt,
      this.updatedAt,
    });

    String id;
    User? user;
    Item item;
    Address deliveryAddress;
    int? quantity;
    double? orderPrice;
    String? status;
    bool? isCod;
    DateTime? deliveryDate;
    DateTime? createdAt;
    DateTime? updatedAt;


    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"] ,
        user : json["user"]!=null&& json["user"].runtimeType!=String 
          ? User.fromJson({...json['user'], "token":""})
          : null,
        item: Item.fromJson(json["item"]),
        quantity: int.tryParse(json["quantity"]),
        orderPrice: double.tryParse(json["orderPrice"].toString()),
        deliveryAddress: Address.fromJson(json["address"]),
        status: json["status"],
        createdAt: DateTime.tryParse(json["createdAt"]??'')?.toLocal(),
        updatedAt: DateTime.tryParse(json["updatedAt"]??'')?.toLocal(),
        deliveryDate: DateTime.tryParse(json["deliveryDate"]??'')?.toLocal(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": item.toJson(),
        "quantity": quantity,
        "orderPrice": orderPrice,
        "address": deliveryAddress.toJson(),
        "status": status,
        "isCOD": isCod,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deliveryDate": deliveryDate?.toIso8601String(),
    };
}


