import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/screens/item_details_screen.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
import 'package:food_delivery_app/widgets/like_button.dart';
import 'package:food_delivery_app/widgets/rating_tile.dart';
import 'package:get/get.dart';


class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      bool isFav = Get.find<UserController>().user?.favItems.contains(item.id)??false;
      return GestureDetector(
        onTap: (){
          AppNavigator.push(context, ItemDetailsScreen(item: item));
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CachedImageContainer(
                      imgUrl: item.images.isNotEmpty
                      ? item.images.first
                      : Constants.defaultPic,
                      borderRadius: BorderRadius.circular(14),
                      width: double.infinity,
                      height: 190,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,vertical: 8
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 4,),
                        Text(
                          "${item.category.join(', ')}"*2,
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
                        // Row(
                        //   children: [
                        //     const Icon(Icons.location_pin,size: 16,),
                        //     Text(
                        //       item.address?.addressLine??'NA',
                        //       style: const TextStyle(
                        //         fontSize: 13
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )

                ],
              ),
            ),

            LikeButton(
              onTap: ()async{
                if(isFav){
                  Get.find<UserController>().removeItemFromFav(item.id);
                }else{
                  Get.find<UserController>().addItemToFav(item.id);
                }
                
              },
              size: 30,
              enabled: isFav,
            )

          ],
        ),
      );
    });
  }
}