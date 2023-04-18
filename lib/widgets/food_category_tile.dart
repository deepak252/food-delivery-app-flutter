import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/models/food_category.dart';

class FoodCategoryTile extends StatelessWidget {
  final FoodCategory category;
  final bool selected;
  final VoidCallback? onTap;
  const FoodCategoryTile({
    super.key, 
    required this.category, 
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 8
        ),
        child: AnimatedScale(
          duration: Duration(milliseconds: 200),
          scale: selected ? 1.15 : 1.0,
          curve: Curves.easeInOut,
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  category.imgPath,
                  height: 65,
                  width: 65,
                ),
              ),
              SizedBox(height: 4,),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 13,
                  color: selected
                   ? Themes.colorPrimary
                   : null
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}