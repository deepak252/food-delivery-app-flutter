
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/utils/date_time_utils.dart';
import 'package:food_delivery_app/utils/num_utils.dart';

class Order {
    Order({
      required this.orderId,
      required this.userId,
      this.user,
      required this.items,
      required this.orderAmount,  
      required this.gstAmount,  
      required this.totalAmount,  
      required this.deliveryAddress,
      // this.quantity,
      this.status,
      // this.isCod,
      this.deliveryDate,
      this.createdAt,
      this.updatedAt,
    });

    String orderId;
    String userId;
    User? user;
    List<CartItem> items;
    Address deliveryAddress;
    // int? quantity;
    double? orderAmount;
    double? gstAmount;
    double? totalAmount;
    String? status;
    // bool? isCod;
    DateTime? deliveryDate;
    DateTime? createdAt;
    DateTime? updatedAt;


    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        userId: json["userId"],
        user : json["user"]!=null&& json["user"].runtimeType!=String 
          ? User.fromJson(json['user'])
          : null,
        items: json["items"] != null
          ? List<CartItem>.from(json["items"].map((x) => CartItem.fromJson(x)))
          : [],
        // item: Item.fromJson(json["item"]),
        // quantity: int.tryParse(json["quantity"]),
        orderAmount: NumUtils.parseDouble(json["orderAmount"]),
        gstAmount : NumUtils.parseDouble(json["gstAmount"]),
        totalAmount: NumUtils.parseDouble(json["totalAmount"]),
        deliveryAddress: Address.fromJson(json["deliveryAddress"]),
        status: json["status"],
        deliveryDate: DateTime.tryParse(json["deliveryDate"]??'')?.toLocal(),
        createdAt: DateTime.tryParse(json["createdAt"]??'')?.toLocal(),
        updatedAt: DateTime.tryParse(json["updatedAt"]??'')?.toLocal(),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "userId": userId,
        "user" : user?.toJson(),
        // "productId": item.toJson(),
        // "quantity": quantity,
        "items": List.from(items.map((x) => x.toJson())),
        "orderAmount": orderAmount,
        "gstAmount": gstAmount,
        "totalAmount": totalAmount,
        "deliveryAddress": deliveryAddress.toJson(),
        "status": status,
        // "isCOD": isCod,
        "deliveryDate": deliveryDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}



extension ExtOrder on Order{
  String get orderName{
    return items.map((e) => e.item?.name??'').join(", ");
  }
  String get date{
    if(createdAt==null){
      return "";
    }
    String d = DateTimeUtils.formatMMMDDYYYY(createdAt!);
    String cd = DateTimeUtils.formatMMMDDYYYY(DateTime.now());
    if(d==cd){
      return "Today";
    }
    return d;
  }
  String get time{
    if(createdAt==null){
      return "";
    }
    return DateTimeUtils.formatHHMM(createdAt!);
  }
  
}
