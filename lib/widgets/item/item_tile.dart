import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';
import 'package:food_delivery_app/widgets/rating_tile.dart';


class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
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
                                fontWeight: FontWeight.bold
                              ),
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

          GestureDetector(
            onTap: ()async{
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                CupertinoIcons.heart,
                color: Colors.redAccent,
                size: 30,
              ),
            ),
          ),

          // if(showFav)
          //   Obx((){
          //     bool isFavorite = _userController.user?.getFavPetIds?.contains(item.petId)==true;
          //     return GestureDetector(
          //       onTap: ()async{
          //         _petController.toggleFavoritePet(item.petId);
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(
          //           isFavorite
          //           ? Icons.favorite
          //           : Icons.favorite_outline_outlined,
          //           color: Colors.redAccent,
          //           size: 30,
          //         ),
          //       ),
          //     );
          //   }),
        ],
      ),
    );
  }
}