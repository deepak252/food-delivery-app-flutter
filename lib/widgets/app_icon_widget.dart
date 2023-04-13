import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/image_path.dart';

class AppIconWidget extends StatelessWidget {
  final double? size;
  const AppIconWidget({ Key? key, this.size =100 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePath.appIcon,
      width: size,
      height: size,
    );
  }
}