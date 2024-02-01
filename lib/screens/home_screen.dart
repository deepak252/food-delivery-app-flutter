

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/constants.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/models/food_category.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/food_category_tile.dart';

import 'package:food_delivery_app/widgets/item/item_tile.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{
  
  final _itemController = Get.put(ItemController());

  @override
  void initState() {
    fetchItems();
    super.initState();
  }

  Future fetchItems()async{
    await _itemController.fetchItems(
      enableLoading: true
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    super.build(context);
    return Scaffold(
      body: Obx((){
        final selectedCategory = _itemController.selectedCategory;
        // return CustomElevatedButton(
        //   text: "Location",
        //   onPressed: ()async{
        //     // print(Timestamp.now().toDate());
        //     // log("${_itemController.items[0].restaurantLocation?.toJson()}");
        //     // var addr = await LocationUtils.getAddressFromCoordinaties(
        //     //   28.6307279, 77.22129489999999
        //     // );
        //     // log("${addr.toJson()}");
        //     //   // 28.6409499, 77.2101718

        //     try{
        //       // ItemService.getItems();
        //       // ItemService.insertItems();
        //       // var a = await GeocodingPlatform.instance.locationFromAddress(
        //       // "1830-31, Ground Floor, Laxmi Narain Street, Chuna Mandi, Paharganj, New Delhi"
        //       // );
        //       // log(a.toString());
        //     }catch(e,s){
        //       log("$e",stackTrace: s);
        //     }
        //   },    
        // );

        return Column(
          children: [
            SizedBox(
              height: 115,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 4),
                itemCount: Constants.foodCategories.length,
                itemBuilder: (BuildContext context, int index){
                  final category = Constants.foodCategories[index];
                  return FoodCategoryTile(
                    category : category,
                    selected: selectedCategory==category,
                    onTap: (){
                      if(selectedCategory==category){
                        _itemController.setCategory = FoodCategory('', '');
                      }else{
                        _itemController.setCategory = category;
                      }
                      fetchItems();
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: _itemController.isLoadingItems
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _itemController.items.isEmpty
                ? NoResultWidget(
                    title: "No Items Found!",
                    onRefresh: ()async{
                    },
                  )
                : RefreshIndicator(
                    onRefresh: fetchItems,
                    child: GridView.builder(
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      itemCount: _itemController.items.length,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                        childAspectRatio: 0.8
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return ItemTile(
                          item : _itemController.items[index],
                        );
                      },
                    ),
                  ),
            ),
          ],
        );
        
      })
     
    );
  }

  @override
  bool get wantKeepAlive=>true;
}
