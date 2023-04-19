import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/models/item.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';


class ItemReviewTile extends StatelessWidget {
  final ItemReview review;
  ItemReviewTile({ Key? key, required this.review}) : super(key: key);

  int _maxCharCount=200;
  final ValueNotifier<bool> _showMoreNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Themes.colorPrimary.withOpacity(0.1),
        // color: Colors.white,
                    
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedImageContainer(
                imgUrl: review.user.profilePic??Constants.defaultPic,
                height: 30,
                width: 30,
                borderRadius: BorderRadius.circular(100),
              ),
              SizedBox(width: 8,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${review.user.fullName} ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        // color: Constants.kTextColor.withOpacity(0.7),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        for(int i=0;i<review.rating;i++)
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Themes.colorPrimary,
                            size: 14,
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8,),
          ValueListenableBuilder<bool>(
            valueListenable: _showMoreNotifier,
            builder: (context, showMore, child) {
              return IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.comment.length>_maxCharCount && !showMore
                      ? "${review.comment.substring(0,_maxCharCount)}"
                      : "${review.comment}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.clip,
                    ),
                    if(review.comment.length>_maxCharCount)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: (){
                            _showMoreNotifier.value = !showMore;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: !showMore
                            ? Text(
                                "Show More",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.clip,
                              )
                            : Text(
                                "Show Less",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.blue
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.clip,
                              ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              review.date,
              style: TextStyle(
                fontSize: 12,
                color: Themes.black300
              ),
            )
          )
        ],
      ),
    );
  }
}