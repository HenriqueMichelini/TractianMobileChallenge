import 'package:flutter/material.dart';
import 'package:tractian_mobile_test/components/assets_button_filter.dart';
import 'package:tractian_mobile_test/components/tree_view.dart';
import 'package:tractian_mobile_test/controllers/api_controller.dart';
import 'package:tractian_mobile_test/models/location.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key, required this.companyId});

  final String companyId;

  @override
  AssetsScreenState createState() => AssetsScreenState();
}

class AssetsScreenState extends State<AssetsScreen> {
  List<Location> locations = [];
  bool isEnergySensorActive = false;
  bool isCriticalActive = false;

  @override
  void initState() {
    super.initState();
    loadTreeData();
  }

  Future<void> loadTreeData() async {
    try {
      final locationsData =
          await ApiController.fetchLocations(widget.companyId);
      final assetsData = await ApiController.fetchAssets(widget.companyId);
      final organizedData =
          ApiController.organizeLocationsAndAssets(locationsData, assetsData);
      setState(() {
        locations = organizedData;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  void toggleEnergySensor() {
    setState(() {
      isEnergySensorActive = !isEnergySensorActive;
      if (isEnergySensorActive) {
        isCriticalActive = false;
      }
    });
  }

  void toggleCritical() {
    setState(() {
      isCriticalActive = !isCriticalActive;
      if (isCriticalActive) {
        isEnergySensorActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'Assets',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 23, 25, 45),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar ativo ou local',
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: AssetsButtonFilter(
                    text: 'Sensor de energia',
                    icon: const Icon(Icons.electric_bolt),
                    isActive: isEnergySensorActive,
                    onToggle: toggleEnergySensor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AssetsButtonFilter(
                    text: 'Crítico',
                    icon: const Icon(Icons.error_outline),
                    isActive: isCriticalActive,
                    onToggle: toggleCritical,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: locations.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : TreeView(locations: locations),
            ),
          ],
        ),
      ),
    );
  }
}
