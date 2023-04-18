import 'package:food_delivery_app/config/image_path.dart';
import 'package:food_delivery_app/models/food_category.dart';

abstract class Constants{
  static const String defaultPic = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";


  static final List<FoodCategory> foodCategories = [
    FoodCategory( "Biryani", ImagePath.biryani, ),
    FoodCategory( "Burger", ImagePath.burger, ),
    FoodCategory( "Cake", ImagePath.cake, ),
    FoodCategory( "Chicken", ImagePath.chicken, ),
    FoodCategory( "Dosa", ImagePath.dosa, ),
    FoodCategory( "Idli", ImagePath.idli, ),
    FoodCategory( "Momos", ImagePath.momos, ),
    FoodCategory( "Paneer", ImagePath.paneer, ),
    FoodCategory( "Pizza", ImagePath.pizza, ),
    FoodCategory( "Rolls", ImagePath.rolls, ),
    FoodCategory( "Thali", ImagePath.thali, ),
  ];

}