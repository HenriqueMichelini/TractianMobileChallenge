class Asset {
  String id;
  String name;
  String? locationId;
  String? parentId;
  String? sensorType;
  List<Asset> subAssets = [];

  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorType,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorType: json['sensorType'],
    );
  }
}
