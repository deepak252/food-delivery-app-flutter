
import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/no_result_widget.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{
  
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
        title: "No Items Found!",
        onRefresh: ()async{
        },
      ),
     
    );
  }

  @override
  bool get wantKeepAlive=>true;
}
