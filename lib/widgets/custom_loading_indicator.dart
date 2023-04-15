import 'package:flutter/material.dart';

void customLoadingIndicator({
  required BuildContext context,
  bool canPop = true
}){
  showDialog(
    context: context, 
    builder: (_)=>WillPopScope(
      onWillPop: () async => canPop,
      child: const Center(child: CircularProgressIndicator()),
    )
  );
}