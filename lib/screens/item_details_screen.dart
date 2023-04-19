import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/bottom_nav_controller.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/widgets/cart_counter.dart';
import 'package:food_delivery_app/widgets/custom_carousel.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_outlined_button.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:food_delivery_app/widgets/item/item_review_tile.dart';
import 'package:food_delivery_app/widgets/like_button.dart';
import 'package:food_delivery_app/widgets/rating_tile.dart';
import 'package:food_delivery_app/widgets/review_item_dialog.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Item item;
  ItemDetailsScreen({ Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final _userController = Get.find<UserController>();
  final _itemController = Get.find<ItemController>();
  final _bottomNavController= Get.find<BottomNavController>();

  late Item item;

  @override
  void initState() {
    item = widget.item;
    _itemController.fetchSpecificItem(item.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx((){
        bool isFav = _userController.getFavItemIds.contains(item.id);
        bool itemInCart = _userController.isItemInCart(item.id);
        int cartItemQty = _userController.getCartItemQty(item.id);
        bool loadingItem = _userController.loadingSingleItem(item.id)
         || _itemController.loadingSingleItem(item.id);
        bool isHindi = _userController.isHindiDesc;
        item = _itemController.getItemById(item.id)??item;
        
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LikeButton(
                      onTap: (){
                        if(isFav){
                          Get.find<UserController>().removeItemFromFav(item.id);
                        }else{
                          Get.find<UserController>().addItemToFav(item.id);
                        }
                      },
                      size: 36,
                      enabled: isFav,
                    ),
                  )
                ],
              ),
              extendBodyBehindAppBar: true,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCarousel(
                    urls: item.images,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,top:20,right: 12,
                        bottom: 84
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    (item.name??''),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                RatingTile(rating: item.rating),
                              ],
                            ),
                            Text(
                              "${item.category.join(', ')}",
                              style: const TextStyle(
                                fontSize: 13,

                              ),
                            ),
                            const SizedBox(height: 6,),
                            Text(
                              '₹ ${item.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Themes.colorPrimary,
                                fontSize: 20
                              ),
                            ),
                            const SizedBox(height: 14,),
                            
                            Text(
                              "${item.restaurantName}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            if(item.restaurantLocation!=null)
                              InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: ()async{
                                  final url = item.restaurantLocation?.mapUrl;
                                  if (url!=null && !await launchUrl(Uri.parse(url))) {
                                    log("Error");
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_pin,size: 16,),
                                      Flexible(
                                        child: Text(
                                          "${item.restaurantLocation?.completeAddress}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Themes.colorPrimary
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 14,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Description",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                btnTranslate(
                                  enabled: isHindi,
                                  onTap: (){
                                    _userController.hindiDesc(!isHindi);
                                  }
                                )
                              ],
                            ),
                            const SizedBox(height: 6,),
                            Text(
                              isHindi
                              ? "${item.descHindi}"
                              : "${item.descEnglish}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),



                            const SizedBox(height: 14,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Reviews (${item.reviews.length})",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                CustomOutlinedButton(
                                  onPressed: ()async{
                                    final res = await reviewItemDialog(
                                      context
                                    );
                                    if(res!=null){
                                      final rating = res["rating"];
                                      final comment = res["comment"];
                                      final reviewAdded = await _itemController.addItemReview(
                                        itemId: item.id, 
                                        review: ItemReview(
                                          user: _userController.user!, 
                                          rating: rating, 
                                          comment: comment, 
                                          createdAt: firestore.Timestamp.now().toDate(),
                                        )
                                      );
                                      if(reviewAdded){
                                        CustomSnackbar.success(msg: "Thanks for your review");
                                      }else{
                                        CustomSnackbar.error(error: "Something went wrong!");
                                      }

                                    }
                                  },
                                  text: "+ Add Review",
                                  textSize: 13,
                                  padding: EdgeInsets.all(6),
                                  width: 0,
                                )
                              ],
                            ),
                            const SizedBox(height: 6,),
                            for(var review in item.reviews)
                              ItemReviewTile(review: review),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Flexible(
                      child: CustomElevatedButton(
                        onPressed: ()async{
                          if(itemInCart){
                            //navigate to cart screen
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            _bottomNavController.changeRoute(index: 1);
                          }else{
                            _userController.addItemToCart(item.id);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                itemInCart
                                ? "Go To Cart"
                                : "Add To Cart",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text(
                              "₹ ${item.price*cartItemQty}",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    if(itemInCart)
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: CartCounter(
                          qty: cartItemQty,
                          onPressIncr: ()async{
                            await _userController.updateCartItemQty(item.id, cartItemQty+1);
                          },
                          onPressDecr: ()async{
                            await _userController.updateCartItemQty(item.id, cartItemQty-1);
                          },
                        ),
                      )

                  ],
                ),
              )
            ),
            if(loadingItem)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      })
    );
  }

  Widget btnTranslate({
    bool enabled =false, VoidCallback? onTap
  }){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
        // margin: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: enabled 
            ? Themes.colorPrimary.withOpacity(0.8)
            : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Themes.colorPrimary,
            width: 1
          ),
        ),
        child: Icon(
          Icons.translate,
          size: 20,
          color:  enabled 
            ? Colors.white
            : Themes.colorPrimary
        ),
      ),
    );
  }
}