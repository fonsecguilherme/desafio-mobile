import 'dart:convert';

import 'address_model.dart';

class LocationInfo {
  final String id;
  final String name;
  final Address address;

  LocationInfo({
    required this.id,
    required this.name,
    required this.address,
  });

  LocationInfo copyWith({
    String? id,
    String? name,
    Address? address,
  }) =>
      LocationInfo(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
      );

  factory LocationInfo.fromJson(String str) =>
      LocationInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationInfo.fromMap(Map<String, dynamic> json) => LocationInfo(
        id: json["id"],
        name: json["name"],
        address: Address.fromMap(json["address"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address.toMap(),
      };
}
