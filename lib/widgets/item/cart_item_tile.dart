
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/screens/item_details_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
import 'package:food_delivery_app/widgets/cart_counter.dart';
import 'package:food_delivery_app/widgets/rating_tile.dart';
import 'package:get/get.dart';


class CartItemTile extends StatelessWidget {
  final Item item;
  CartItemTile({super.key, required this.item});

  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      // bool isFav = _userController.getFavItemIds.contains(item.id);
      // bool itemInCart = _userController.isItemInCart(item.id);
      int cartItemQty = _userController.getCartItemQty(item.id);
      // bool loadingItem = _userController.loadingSingleItem(item.id);
      
      return GestureDetector(
        onTap: (){
          AppNavigator.push(context, ItemDetailsScreen(item: item));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
          margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [ 
              BoxShadow(
              color: Colors.black.withAlpha(20), 
              spreadRadius: 1, 
              blurRadius: 5,
            ),]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: CachedImageContainer(
                  imgUrl: item.images.isNotEmpty
                  ? item.images.first
                  : Constants.defaultPic,
                  borderRadius: BorderRadius.circular(14),
                  width: double.infinity,
                  height: 150,
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,vertical: 8
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.name??'',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4,),
                          RatingTile(rating: item.rating)
                        ],
                      ),
                      SizedBox(height: 6,),
                      Text(
                        "${item.category.join(', ')}",
                        style: const TextStyle(
                          fontSize: 13, 
                        ), 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "₹ ${item.price}",
                        style: const TextStyle(
                          fontSize: 13
                        ),
                      ),
                      // Spacer(),
                      SizedBox(height: 6,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CartCounter(
                            qty: cartItemQty,
                            onPressIncr: ()async{
                              await _userController.updateCartItemQty(item.id, cartItemQty+1);
                            },
                            onPressDecr: ()async{
                              await _userController.updateCartItemQty(item.id, cartItemQty-1);
                            },
                          ),
                          InkWell(
                            onTap: ()async{
                              await _userController.removeItemFromCart(item.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.delete,
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

