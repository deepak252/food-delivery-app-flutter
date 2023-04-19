import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:food_delivery_app/widgets/custom_text_field.dart';


Future  reviewItemDialog(BuildContext context,)async{
  final ValueNotifier<int> _ratingNotifier = ValueNotifier(0);
  final  _reviewController = TextEditingController();
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Themes.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 14),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 42
        ),
        contentPadding: EdgeInsets.only(
          left: 18,right: 18,top: 16,bottom: 12
        ),
        title: Center(
          child: Text(
            "Add Your Review",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: _ratingNotifier,
                builder: (context,ratings, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 5; i++)
                        Flexible(
                          child: GestureDetector(
                            onTap: (){
                              _ratingNotifier.value=i+1;
                            },
                            child: Icon(
                              i<ratings ?  CupertinoIcons.star_fill : CupertinoIcons.star,
                              color: Themes.colorPrimary,
                              size: 40,
                            ),
                          ),
                        ),
                    ],
                  );
                }
              ),
              SizedBox(height: 20,),
              CustomTextField(
                controller: _reviewController,
                maxLines: 8,
                maxLength: 200,
                hintText: "Share you opinion ...",
              ),
              SizedBox(height: 20,),
              CustomElevatedButton(
                onPressed: ()async{
                  if(_ratingNotifier.value==0){
                    CustomSnackbar.error(error: "Select rating stars");
                    return;
                  }
                  if(_reviewController.text.trim().isEmpty){
                    CustomSnackbar.error(error: "Review cannot be empty");
                    return;
                  }
                  Navigator.pop(context, {
                    "rating" : _ratingNotifier.value,
                    "comment" : _reviewController.text
                  });
                }, 
                text: 'Submit',
                boldText: false,
                textSize: 15,
              ),
            ],
          ),
        ),
      );
    });
}