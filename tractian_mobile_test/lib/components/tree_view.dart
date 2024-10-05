import 'package:flutter/material.dart';
import 'package:tractian_mobile_test/models/asset.dart';
import '../models/location.dart';
import '../components/tree_view_tile.dart';

class TreeView extends StatelessWidget {
  final List<Location> locations;

  const TreeView({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: locations
          .map((loc) => buildLocationTile(loc))
          .whereType<Widget>() // Filtra diretamente os valores nulos
          .toList(),
    );
  }

  Widget? buildLocationTile(Location location) {
    // Filtrar assets que contenham componentes 'operating'
    final filteredAssets = location.assets
        .map((asset) => filterAssetByStatus(asset))
        .whereType<Widget>() // Filtra diretamente os valores nulos
        .toList();

    // Filtrar subLocations
    final filteredSubLocations = location.subLocations
        .map((subLoc) => buildLocationTile(subLoc))
        .whereType<Widget>() // Filtra diretamente os valores nulos
        .toList();

    // Se não houver subLocs ou assets válidos, retorna nulo
    if (filteredSubLocations.isEmpty && filteredAssets.isEmpty) {
      return null;
    }

    // Construir o Tile da localização se houver algo para exibir
    return TreeViewTile(
      location: location,
      filteredAssets: filteredAssets, // Lista agora é garantidamente não nula
      filteredSubLocations:
          filteredSubLocations, // Lista agora é garantidamente não nula
    );
  }

  // Função para filtrar assets e subAssets
  Widget? filterAssetByStatus(Asset asset) {
    // Filtrar os subAssets recursivamente
    final filteredSubAssets = asset.subAssets
        .map((subAsset) => filterAssetByStatus(subAsset))
        .whereType<Widget>() // Filtra diretamente os valores nulos
        .toList();

    // Verifica se o asset atual ou seus subAssets têm status 'operating'
    if (asset.status == 'operating' || filteredSubAssets.isNotEmpty) {
      return buildAssetTile(asset, filteredSubAssets);
    }
    return null;
  }

  // Função para construir o asset tile
  Widget buildAssetTile(Asset asset, List<Widget> filteredSubAssets) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
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
          ],
        ),
        subtitle: asset.sensorType != null
            ? Text("Component - ${asset.sensorType}")
            : null,
        children: filteredSubAssets,
      ),
    );
  }
}
