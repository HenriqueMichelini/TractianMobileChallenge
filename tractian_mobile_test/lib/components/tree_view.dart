import 'package:flutter/material.dart';
import '../models/location.dart';
import '../components/tree_view_tile.dart';

class TreeView extends StatelessWidget {
  final List<Location> locations;

  const TreeView({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: locations.map((loc) => buildLocationTile(loc)).toList(),
    );
  }

  Widget buildLocationTile(Location location) {
    return TreeViewTile(location: location);
  }
}
