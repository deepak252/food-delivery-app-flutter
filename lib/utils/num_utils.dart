import 'package:get/get.dart';

class NumUtils{
  static double parseDouble(dynamic num,{int? precision} ){
    switch(num.runtimeType){
      case double : {break;}
      case int : {num = num.toDouble(); break;}
      case String :{  num = double.tryParse(num)??0.0; break;}
      default : num = 0.0;
    }
    if(precision!=null){
      num = (num as double).toPrecision(precision);
    }
    return num;
  }

}