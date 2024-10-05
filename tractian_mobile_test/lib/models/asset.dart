class Asset {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final List<Asset> subAssets; // Modificado para ser final

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    List<Asset>? subAssets, // Aceitar como argumento opcional
  }) : subAssets =
            subAssets ?? []; // Inicializa com uma lista vazia, se não fornecido

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
      // Presumindo que você pode ter uma lista de subAssets no JSON
      subAssets: (json['subAssets'] as List<dynamic>?)
              ?.map((item) => Asset.fromJson(item))
              .toList() ??
          [],
    );
  }
}
