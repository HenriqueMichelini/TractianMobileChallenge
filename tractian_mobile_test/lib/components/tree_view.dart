import 'package:flutter/material.dart';
import 'package:tractian_mobile_test/models/asset.dart';
import '../models/location.dart';
import '../components/tree_view_tile.dart';

class TreeView extends StatelessWidget {
  final List<Location> locations;
  final bool isEnergySensorActive; // Novo parâmetro para filtro de energia
  final bool isCriticalActive; // Novo parâmetro para filtro crítico

  const TreeView({
    super.key,
    required this.locations,
    required this.isEnergySensorActive,
    required this.isCriticalActive,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: locations
          .map((loc) => buildLocationTile(loc))
          .whereType<Widget>()
          .toList(),
    );
  }

  Widget? buildLocationTile(Location location) {
    // Filtrar assets que contenham componentes 'operating' ou 'alert'
    List<Widget> filteredAssets = []; // Lista mutável para ativos filtrados
    for (var asset in location.assets) {
      final assetTile = filterAssetByStatus(asset);
      if (assetTile != null) {
        filteredAssets.add(assetTile);
      }
    }

    // Filtrar subLocations
    List<Widget> filteredSubLocations =
        []; // Lista mutável para sublocações filtradas
    for (var subLoc in location.subLocations) {
      final subLocationTile = buildLocationTile(subLoc);
      if (subLocationTile != null) {
        filteredSubLocations.add(subLocationTile);
      }
    }

    // Se não houver subLocs ou assets válidos, retorna nulo
    if (filteredSubLocations.isEmpty && filteredAssets.isEmpty) {
      return null;
    }

    // Construir o Tile da localização se houver algo para exibir
    return TreeViewTile(
      location: location,
      filteredAssets: filteredAssets,
      filteredSubLocations: filteredSubLocations,
      isExpanded: isEnergySensorActive ||
          isCriticalActive, // Expande apenas se algum filtro estiver ativo
    );
  }

  Widget? filterAssetByStatus(Asset asset) {
    // Filtrar os subAssets recursivamente
    final filteredSubAssets = <Widget>[];

    for (final subAsset in asset.subAssets) {
      final subAssetTile = filterAssetByStatus(subAsset);
      if (subAssetTile != null) {
        filteredSubAssets.add(subAssetTile);
      }
    }

    // Verifica se o asset atual ou seus subAssets têm status 'operating' se o filtro de energia estiver ativo
    if (isEnergySensorActive &&
        (asset.status == 'operating' || filteredSubAssets.isNotEmpty)) {
      return buildAssetTile(asset, filteredSubAssets);
    }

    // Verifica se o asset atual ou seus subAssets têm status 'alert' se o filtro crítico estiver ativo
    if (isCriticalActive &&
        (asset.status == 'alert' || filteredSubAssets.isNotEmpty)) {
      return buildAssetTile(asset, filteredSubAssets);
    }

    // Se nenhum filtro estiver ativo, retornar todos os assets
    if (!isEnergySensorActive && !isCriticalActive) {
      return buildAssetTile(
          asset, filteredSubAssets); // Retorna todos os ativos
    }

    return null; // Retorna nulo se não houver critérios atendidos
  }

  // Função para construir o asset tile
  Widget buildAssetTile(Asset asset, List<Widget> filteredSubAssets) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: filteredSubAssets.isNotEmpty // Checa se há subAssets
          ? ExpansionTile(
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
                    const Icon(Icons.electric_bolt,
                        color: Colors.green, size: 16),
                  if (asset.status == 'alert')
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 16),
                ],
              ),
              subtitle: asset.sensorType != null
                  ? Text("Component - ${asset.sensorType}")
                  : null,
              children: filteredSubAssets,
            )
          : ListTile(
              // Substitui por ListTile se não houver subAssets
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
                    const Icon(Icons.electric_bolt,
                        color: Colors.green, size: 16),
                  if (asset.status == 'alert')
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 16),
                ],
              ),
              subtitle: asset.sensorType != null
                  ? Text("Component - ${asset.sensorType}")
                  : null,
            ),
    );
  }
}
