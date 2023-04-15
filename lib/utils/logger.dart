
import 'dart:developer';
class Logger{
  String className="";
  Logger(this.className);

  void message(String method, Object? message){
    log("MESSAGE : $className -> $method : $message ");
  }

  void error(String method,{required Object? error, StackTrace? stackTrace}){
    log("ERROR : $className -> $method", error: error, stackTrace: stackTrace);
  }

}