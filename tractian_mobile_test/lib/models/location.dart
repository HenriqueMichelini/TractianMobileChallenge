import 'package:tractian_mobile_test/models/asset.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;
  final List<Location> subLocations;
  final List<Asset> assets;

  Location({
    required this.id,
    required this.name,
    this.parentId,
    List<Location>? subLocations,
    List<Asset>? assets,
  })  : subLocations = subLocations ?? [],
        assets = assets ?? [];

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      subLocations: (json['subLocations'] as List<dynamic>?)
              ?.map((item) => Location.fromJson(item))
              .toList() ??
          [],
      assets: (json['assets'] as List<dynamic>?)
              ?.map((item) => Asset.fromJson(item))
              .toList() ??
          [],
    );
  }
}
