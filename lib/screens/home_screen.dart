
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/item_controller.dart';
import 'package:food_delivery_app/services/firestore_service.dart';
import 'package:food_delivery_app/services/item_service.dart';
import 'package:food_delivery_app/utils/location_utils.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/item/item_tile.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:geocoding/geocoding.dart';
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
    _itemController.fetchFoodItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    super.build(context);
    return Scaffold(
      body: Obx((){
        if(_itemController.isLoadingItems){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(_itemController.items.length==0){
          return NoResultWidget(
            title: "No Items Found!",
            onRefresh: ()async{
            },
          );
        }
        
        // return CustomElevatedButton(
        //   text: "Location",
        //   onPressed: ()async{
        //     // var addr = await LocationUtils.getAddressFromCoordinaties(
        //     //   28.6409499, 77.2101718
        //     // );
        //     try{
        //       ItemService.getItems();
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

        return RefreshIndicator(
          onRefresh: ()async{
            await _itemController.fetchFoodItems();
          },
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6),
            itemCount: _itemController.items.length,
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
        );
        
      })
     
    );
  }

  @override
  bool get wantKeepAlive=>true;
}
