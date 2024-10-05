import 'package:tractian_mobile_test/models/asset.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;
  final List<Location> subLocations; // Modificado para ser final
  final List<Asset> assets; // Modificado para ser final

  Location({
    required this.id,
    required this.name,
    this.parentId,
    List<Location>? subLocations, // Aceitar como argumento opcional
    List<Asset>? assets, // Aceitar como argumento opcional
  })  : subLocations = subLocations ??
            [], // Inicializa com uma lista vazia, se não fornecido
        assets =
            assets ?? []; // Inicializa com uma lista vazia, se não fornecido

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      // Presumindo que você pode ter uma lista de subLocations no JSON
      subLocations: (json['subLocations'] as List<dynamic>?)
              ?.map((item) => Location.fromJson(item))
              .toList() ??
          [],
      // Presumindo que você pode ter uma lista de assets no JSON
      assets: (json['assets'] as List<dynamic>?)
              ?.map((item) => Asset.fromJson(item))
              .toList() ??
          [],
    );
  }
}
