import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';

class TreeViewTile extends StatelessWidget {
  final Location location;

  const TreeViewTile({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(location.name),
      children: [
        ...location.subLocations
            .map((subLoc) => TreeViewTile(location: subLoc)),
        ...location.assets.map(buildAssetTile),
      ],
    );
  }

  Widget buildAssetTile(Asset asset) {
    return ExpansionTile(
      title: Text(asset.name),
      subtitle: asset.sensorType != null
          ? Text("Component - ${asset.sensorType}")
          : null,
      children: asset.subAssets.map(buildAssetTile).toList(),
    );
  }
}
