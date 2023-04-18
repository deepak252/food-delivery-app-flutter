import 'package:food_delivery_app/utils/num_utils.dart';


class Address {
  String? completeAddress;
  String? name;
  String? sublocality;
  String? state;
  String? city;
  String? country;
  String? pincode;
  double lng;
  double lat;

  Address({
    this.completeAddress,
    this.name,
    this.sublocality,
    this.city, 
    this.state, 
    this.country,
    this.pincode,
    required this.lng,
    required this.lat
  }){
    completeAddress = getCompleteAddress;
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      completeAddress: json["completeAddress"],
      name: json["name"],
      sublocality: json["sublocality"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      pincode: json["pincode"],
      lat: NumUtils.parseDouble(json["lat"]),
      lng: NumUtils.parseDouble(json["lat"]),
  );


    Map<String, dynamic> toJson() => {
        "completeAddress": completeAddress,
        "name": name,
        "sublocality": sublocality,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode,
        "lat": lat,
        "lng": lng,
    };

  Address copyWith({
    String? completeAddress,
    String? name,
    String? sublocality,
    String? state,
    String? city,
    String? country,
    String? pincode,
    double? lng,
    double? lat,
  }) {
    return Address(
      completeAddress: completeAddress ?? this.completeAddress,
      name: name ?? this.name,
      sublocality: sublocality ?? this.sublocality,
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
    );
  }
}

extension AddrExtension on Address{
  String? get getCompleteAddress{
    if(completeAddress==null){
      if(name!=null){
        completeAddress = "$name";
      }
      if(sublocality!=null){
        completeAddress = completeAddress!=null
          ? "${completeAddress}, $sublocality"
          : "$sublocality";
      }
      if(city!=null){
        completeAddress = completeAddress!=null
          ? "${completeAddress}, $city"
          : "$city";
      }
      if(state!=null){
        completeAddress = completeAddress!=null
          ? "${completeAddress}, $state"
          : "$state";
      }
      if(pincode!=null){
        completeAddress = completeAddress!=null
          ? "${completeAddress} - $pincode"
          : null;
      }
    }
    return completeAddress;
  }
}
