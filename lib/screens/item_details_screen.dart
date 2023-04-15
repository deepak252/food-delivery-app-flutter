import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/widgets/custom_carousel.dart';
import 'package:food_delivery_app/widgets/like_button.dart';
import 'package:get/get.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;
  const ItemDetailsScreen({ Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LikeButton(
                size: 36,
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
                          Text(
                            '₹ ${item.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Themes.colorPrimary,
                              fontSize: 20
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6,),
                      // if(pet.breed?.trim()!='')
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 3),
                      //     child: Text(
                      //       "Breed : ${pet.breed}",
                      //       style: const TextStyle(
                      //         fontSize: 16
                      //       ),
                      //     ),
                      //   ),
                      // if(pet.age!=null)
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 3),
                      //     child: Text(
                      //       "Age : ${pet.age} year",
                      //       style: const TextStyle(
                      //         fontSize: 16
                      //       ),
                      //     ),
                      //   ),
                      const SizedBox(height: 6,),
                      if(item.resName!=null)
                        Text(
                          "${item.resName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      Row(
                        children: [
                          const Icon(Icons.location_pin,size: 16,),
                          Flexible(
                            child: Text(
                              "${item.location?.name}",
                              style: const TextStyle(
                                fontSize: 16
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 6,),
                      Text(
                        "${item.descEnglish}",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: CustomElevatedButton(
        //     onPressed: ()async{
        //       if(pet.user!=null){
        //         showUserProfile(pet.user!);
        //       }
        //     },
        //     text: "Contact",
        //   ),
        // )
      ),
    );
    
  }
}