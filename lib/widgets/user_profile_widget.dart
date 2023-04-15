import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/models/user.dart';
import 'package:food_delivery_app/widgets/cached_image_container.dart';

class UserProfileWidget extends StatelessWidget {
  final User? user;
  const UserProfileWidget({this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Profile Pic
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CachedImageContainer(
              imgUrl: user?.profilePic??Constants.defaultPic,
              height: 80,
              width: 80,
              borderRadius: BorderRadius.circular(100),
            )
          ),
          const SizedBox(height: 12,),
          Text(
            user!=null
            ? "${user?.fullName}"
            : "Sign In",
            style: const TextStyle(
              fontSize: 20
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8,),
          Text(
            user?.email??'',
            style: const TextStyle(
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            user?.phone??'',
            style: const TextStyle(
              fontSize: 14
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          
        ],
      ),
    );
  }

}