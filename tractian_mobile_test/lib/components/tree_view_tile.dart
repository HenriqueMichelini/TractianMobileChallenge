import 'package:flutter/material.dart';
import '../models/location.dart';
import '../models/asset.dart';

class TreeViewTile extends StatelessWidget {
  final Location location;
  final List<Widget> filteredAssets;
  final List<Widget> filteredSubLocations;
  final double indentLevel;

  const TreeViewTile({
    super.key,
    required this.location,
    required this.filteredAssets,
    required this.filteredSubLocations,
    this.indentLevel = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Definindo a indentação para o Tile da localização
    return Padding(
      padding: EdgeInsets.only(left: indentLevel * 20.0),
      child: Column(
        children: [
          // Usar ExpansionTile apenas se houver subLocs ou assets
          if (filteredSubLocations.isNotEmpty || filteredAssets.isNotEmpty)
            ExpansionTile(
              leading: Image.asset(
                'assets/location.png',
                width: 24,
                height: 24,
              ),
              title: Text(location.name),
              initiallyExpanded: true, // Sempre abrir o Tile
              children: [
                ...filteredSubLocations,
                ...filteredAssets,
              ],
            )
          else
            // Se não houver filhos, apenas exibe o nome da localização
            ListTile(
              leading: Image.asset(
                'assets/location.png',
                width: 24,
                height: 24,
              ),
              title: Text(location.name),
            ),
        ],
      ),
    );
  }
}
