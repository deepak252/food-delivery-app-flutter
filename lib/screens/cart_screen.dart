
import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({ Key? key }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen>{
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    super.build(context);
    return Scaffold(
      body : NoResultWidget(
        title: "Cart is Empty!",
        onRefresh: ()async{
        },
      ),
     
    );
  }

  @override
  bool get wantKeepAlive=>true;
}
