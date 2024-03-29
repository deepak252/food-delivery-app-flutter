import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';

class CartCounter extends StatelessWidget {
  final int qty;
  final VoidCallback? onPressIncr;
  final VoidCallback? onPressDecr;
  final bool densed;
  const CartCounter({
    this.qty=1, 
    this.onPressDecr, 
    this.onPressIncr, 
    this.densed=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Themes.colorPrimary
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children :[
          IconButton(
            onPressed: onPressDecr, 
            visualDensity: densed 
            ? VisualDensity.compact
            : null,
            icon: Icon(
              Icons.remove,
              size: 20,
            )
          ),
          Text(
            "$qty",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Themes.colorPrimary
            ),
          ),
          IconButton(
            onPressed: onPressIncr,
            visualDensity: densed 
            ? VisualDensity.compact
            : null,
            icon: Icon(
              Icons.add,
              size: 20,
            )
          ),
          
        ]
      ),
    );
  }
}