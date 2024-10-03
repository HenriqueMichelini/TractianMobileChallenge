import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';

class TreeViewTile extends StatelessWidget {
  final Location location;
  final double indentLevel;

  const TreeViewTile({super.key, required this.location, this.indentLevel = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indentLevel * 20.0),
      child: ExpansionTile(
        leading: Image.asset(
          'assets/location.png',
          width: 24,
          height: 24,
        ),
        title: Text(location.name),
        children: [
          ...location.subLocations.map((subLoc) =>
              TreeViewTile(location: subLoc, indentLevel: indentLevel + 1)),
          ...location.assets.map((asset) => buildAssetTile(asset)),
        ],
      ),
    );
  }

  Widget buildAssetTile(Asset asset) {
    return Padding(
      padding: EdgeInsets.only(left: (indentLevel + 1) * 20.0),
      child: ExpansionTile(
        leading: Image.asset(
          asset.sensorType != null
              ? 'assets/component.png'
              : 'assets/asset.png',
          width: 24,
          height: 24,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(asset.name),
            ),
            if (asset.status == 'operating')
              const Icon(Icons.electric_bolt, color: Colors.green, size: 16),
            if (asset.status == 'alert')
              const Icon(Icons.circle, color: Colors.red, size: 16),
          ],
        ),
        subtitle: asset.sensorType != null
            ? Text("Component - ${asset.sensorType}")
            : null,
        children: asset.subAssets.map(buildAssetTile).toList(),
      ),
    );
  }
}
