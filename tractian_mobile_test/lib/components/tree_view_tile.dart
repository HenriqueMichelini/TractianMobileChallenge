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
      padding:
          EdgeInsets.only(left: indentLevel * 20.0), // Add space for nesting
      child: ExpansionTile(
        leading: Image.asset('assets/location.png'), // Location icon
        title: Text(location.name),
        children: [
          // Recursively add sublocations with increased indent
          ...location.subLocations
              .map((subLoc) =>
                  TreeViewTile(location: subLoc, indentLevel: indentLevel + 1))
              .toList(),
          // Add assets under this location with increased indent
          ...location.assets.map((asset) => buildAssetTile(asset)).toList(),
        ],
      ),
    );
  }

  Widget buildAssetTile(Asset asset) {
    return Padding(
      padding: EdgeInsets.only(
          left: (indentLevel + 1) * 20.0), // Add space for asset nesting
      child: ExpansionTile(
        leading: Image.asset(asset.sensorType != null
            ? 'assets/component.png'
            : 'assets/asset.png'), // Differentiate between asset and component
        title: Text(asset.name),
        subtitle: asset.sensorType != null
            ? Text("Component - ${asset.sensorType}")
            : null,
        // If the asset has sub-assets, display them with more indentation
        children: asset.subAssets
            .map((subAsset) => buildAssetTile(subAsset))
            .toList(),
      ),
    );
  }
}
