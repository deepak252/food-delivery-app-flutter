
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/config/app_theme.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/models/address.dart';
import 'package:food_delivery_app/utils/location_utils.dart';
import 'package:food_delivery_app/utils/text_validator.dart';
import 'package:food_delivery_app/widgets/custom_elevated_button.dart';
import 'package:food_delivery_app/widgets/custom_snackbar.dart';
import 'package:food_delivery_app/widgets/custom_text_field.dart';
import 'package:get/get.dart';

Future showAddressBottomSheet(Address? address)async{
  return await Get.bottomSheet(
    AddressBottomSheet(address: address,),
    backgroundColor: Themes.backgroundColor,

    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16)
      )
    )
  );
}

class AddressBottomSheet extends StatefulWidget {
  final Address? address;
  AddressBottomSheet({ Key? key, required this.address}) : super(key: key);

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final _userController = Get.find<UserController>();
  final  _addrLineController = TextEditingController();
  final  _cityController = TextEditingController();
  final  _stateController = TextEditingController();
  final  _pincodeController = TextEditingController();
  Address? address;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    address = widget.address;
    initControllers();
    super.initState();
  }

  void initControllers() {

    if(address!=null){
      
      _addrLineController.text = (address?.name??'')+' '+(address?.sublocality??'');
      _cityController.text = address?.city??"";
      _stateController.text = address?.state??"";
      _pincodeController.text = address?.pincode??"";
    }
  }

  @override
  void dispose() {
    _addrLineController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text("Address")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _addrLineController,
                  hintText: " Address Line*",
                  validator: TextValidator.requiredText,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 18,),
                CustomTextField(
                  controller: _cityController,
                  hintText: " City*",
                  validator: TextValidator.requiredText,
                ),

                const SizedBox(height: 18,),
                CustomTextField(
                  controller: _stateController,
                  hintText: " State*",
                  validator: TextValidator.requiredText,
                ),
                const SizedBox(height: 18,),
                CustomTextField(
                  controller: _pincodeController,
                  hintText: " Pincode*",
                  validator: TextValidator.requiredText,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(
                  height: isKeyboardOpen
                  ? 20
                  : 90,
                ),
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: !isKeyboardOpen ? Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomElevatedButton(
          onPressed: ()async{
            try{
              final addrLine  = _addrLineController.text.trim();
              final city  = _cityController.text.trim();
              final state  = _stateController.text.trim();
              final pincode  = _pincodeController.text.trim();

              if(address!=null){
                if(
                  address!.name!= addrLine ||
                  address!.city!= city || 
                  address!.state!= state || 
                  address!.pincode!= pincode
                ){
                  //Current location changed
                  final location = await LocationUtils.getCoordinatesFromAddress(
                    "$addrLine, $city, $state, $pincode"
                  );
                  if(location!=null){
                    address = await getAddress(addrLine, city, state, pincode);
                  }
                }
              }else{
                address = await getAddress(addrLine, city, state, pincode);
              }
              log("ADDR2 : ${address?.toJson()}");  
              if(address==null){
                throw "Couldn't update address!";
              }
              bool? res = await _userController.updateProfile(
                updatedUser: _userController.user!.copyWith(
                  address: address
                )
              );
              if(res==true){
                Navigator.pop(context);
              }else{
                throw "Couldn't update address!";
              }

            }catch(e,s){
              CustomSnackbar.error(error: e);
              log("ERROR", error: e, stackTrace: s);
            }
          },
          text: "Save",
        ),
      ) : null,
    );
  }

  Future<Address?> getAddress(String addrLine, String city, String state, String pincode)async{
    final inputAddr =  "$addrLine, $city, $state - $pincode";
    final loc = await LocationUtils.getCoordinatesFromAddress(
      inputAddr
    );
    if(loc!=null){
      final address = await LocationUtils.getAddressFromCoordinaties(
        loc.latitude, loc.longitude
      );
      log("ADDR1 : ${address.toJson()}");
      return address.copyWith(
        completeAddress: inputAddr,
        name: addrLine,
        city: city,
        state: state,
        pincode: pincode
      );

    }
  }
}