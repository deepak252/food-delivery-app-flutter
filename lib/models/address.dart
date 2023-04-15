import 'package:food_delivery_app/utils/num_utils.dart';

class Address {
    Address({
        required this.name,
        required this.address,
        required this.lat,
        required this.lng,
    });

    String name;
    String address;
    double lat;
    double lng;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        address: json["address"],
        lat: NumUtils.parseDouble(json["lat"]),
        lng: NumUtils.parseDouble(json["lng"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "lat": lat,
        "lng": lng,
    };
}

// class Address {
//   final String? name;
//   final String? sublocality;
//   final String? state;
//   final String? city;
//   final String? country;
//   final String? pincode;
//   final double longitude;
//   final double latitude;

//   Address({
//     this.name,
//     this.sublocality,
//     this.state, 
//     this.city, 
//     this.country,
//     this.pincode,
//     required this.longitude,
//     required this.latitude
//   });

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//       city: json["city"],
//       state: json["state"],
//       country: json["country"],
//       pincode: json["pincode"],
//       latitude: double.tryParse(json["latitude"]??'')??0.0,
//       longitude: double.tryParse(json["longitude"]??'')??0.0,
//   );


//     Map<String, dynamic> toJson() => {
//         "city": city,
//         "state": state,
//         "country": country,
//         "pincode": pincode,
//         "latitude": latitude,
//         "longitude": longitude,
//     };
// }
