import 'package:flutter/material.dart';
import 'package:tractian_mobile_test/components/unit_button.dart';
import 'package:tractian_mobile_test/views/assets_screen.dart';

class UnitsScreen extends StatelessWidget {
  const UnitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToAsset(String companyId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssetsScreen(companyId: companyId),
        ),
      );
    }

    String jaguarId = '662fd0ee639069143a8fc387';
    String tobiasId = '662fd0fab3fd5656edb39af5';
    String apexId = '662fd100f990557384756e58';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TRACTIAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 23, 25, 45),
      ),
      body: Column(
        children: [
          UnitsButton(
              title: 'Jaguar', function: () => navigateToAsset(jaguarId)),
          UnitsButton(
              title: 'Tobias', function: () => navigateToAsset(tobiasId)),
          UnitsButton(title: 'Apex', function: () => navigateToAsset(apexId)),
        ],
      ),
    );
  }
}
