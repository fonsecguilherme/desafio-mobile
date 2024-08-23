import 'dart:convert';

class Address {
  final String city;
  final String state;
  final String address;
  final String latitude;
  final String longitude;

  Address({
    required this.city,
    required this.state,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Address copyWith({
    String? city,
    String? state,
    String? address,
    String? latitude,
    String? longitude,
  }) =>
      Address(
        city: city ?? this.city,
        state: state ?? this.state,
        address: address ?? this.address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        city: json["city"],
        state: json["state"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "state": state,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
