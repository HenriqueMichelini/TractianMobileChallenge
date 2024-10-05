class Asset {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final List<Asset> subAssets;

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
    List<Asset>? subAssets,
  }) : subAssets = subAssets ?? [];

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
      status: json['status'],
      subAssets: (json['subAssets'] as List<dynamic>?)
              ?.map((item) => Asset.fromJson(item))
              .toList() ??
          [],
    );
  }
}
