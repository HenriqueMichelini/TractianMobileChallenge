import 'package:flutter/material.dart';
import '../models/location.dart';

class TreeViewTile extends StatelessWidget {
  final Location location;
  final List<Widget> filteredAssets; // Lista de ativos filtrados
  final List<Widget> filteredSubLocations; // Lista de sublocações filtradas
  final double indentLevel;
  final bool isExpanded; // Nova propriedade para controlar a expansão

  const TreeViewTile({
    super.key,
    required this.location,
    required this.filteredAssets,
    required this.filteredSubLocations,
    this.indentLevel = 0,
    required this.isExpanded, // Inicializa a nova propriedade
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indentLevel * 20.0),
      child: Column(
        children: [
          if (filteredSubLocations.isNotEmpty || filteredAssets.isNotEmpty)
            ExpansionTile(
              leading: Image.asset(
                'assets/location.png',
                width: 24,
                height: 24,
              ),
              title: Text(location.name),
              initiallyExpanded:
                  isExpanded, // Usar a nova propriedade para controlar a expansão
              children: [
                ...filteredSubLocations,
                ...filteredAssets,
              ],
            )
          else
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
