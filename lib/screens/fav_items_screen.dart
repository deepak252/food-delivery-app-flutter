
import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';

import 'package:food_delivery_app/widgets/item/item_tile.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class FavItemsScreen extends StatefulWidget {
  const FavItemsScreen({ Key? key }) : super(key: key);

  @override
  State<FavItemsScreen> createState() => _FavItemsScreenState();
}

class _FavItemsScreenState extends State<FavItemsScreen> {
  
  final _itemController = Get.find<ItemController>();
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    fetchFavItems();
    super.initState();
  }

  Future fetchFavItems()async{
    await _itemController.fetchFavItems(
      favItemIds :  _userController.getFavItemIds,
      enableLoading: true
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
        ),
        titleSpacing: 0,
      ),
      body: Obx((){
        if(_itemController.isLoadingFavItems){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(_itemController.favItems.length==0){
          return NoResultWidget(
            title: "No Favorite!",
            onRefresh: ()async{
            },
          );
        }
        
        return RefreshIndicator(
          onRefresh: fetchFavItems,
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6),
            itemCount: _itemController.favItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
              childAspectRatio: 0.8
            ),
            itemBuilder: (BuildContext context, int index){
              return ItemTile(
                item : _itemController.favItems[index],
              );
            },
          ),
        );
        
      })
     
    );
  }

}
