import 'package:tractian_mobile_test/models/asset.dart';

class Location {
  String id;
  String name;
  String? parentId;
  List<Location> subLocations = [];
  List<Asset> assets = [];

  Location({required this.id, required this.name, this.parentId});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
