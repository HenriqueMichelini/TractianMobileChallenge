import 'package:http/http.dart' as http;
import 'package:tractian_mobile_test/models/asset.dart';
import 'dart:convert';

import 'package:tractian_mobile_test/models/location.dart';

class ApiController {
  static Future<List<dynamic>> fetchLocations(String companyId) async {
    final response = await http.get(Uri.parse(
        'https://fake-api.tractian.com/companies/$companyId/locations'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load locations');
    }
  }

  static Future<List<dynamic>> fetchAssets(String companyId) async {
    final response = await http.get(
        Uri.parse('https://fake-api.tractian.com/companies/$companyId/assets'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load assets');
    }
  }

  static List<Location> organizeLocationsAndAssets(
      List<dynamic> locationsData, List<dynamic> assetsData) {
    Map<String, Location> locationsMap = {};
    Map<String, Asset> assetsMap = {};

    // Parse locations and assets into maps
    for (var loc in locationsData) {
      Location location = Location.fromJson(loc);
      locationsMap[location.id] = location;
    }

    for (var asset in assetsData) {
      Asset newAsset = Asset.fromJson(asset);
      assetsMap[newAsset.id] = newAsset;
    }

    // Link sub-locations and sub-assets
    for (var loc in locationsMap.values) {
      if (loc.parentId != null) {
        locationsMap[loc.parentId]?.subLocations.add(loc);
      }
    }

    for (var asset in assetsMap.values) {
      if (asset.locationId != null) {
        locationsMap[asset.locationId]?.assets.add(asset);
      } else if (asset.parentId != null) {
        assetsMap[asset.parentId]?.subAssets.add(asset);
      }
    }

    // Return root locations (locations without a parent)
    return locationsMap.values.where((loc) => loc.parentId == null).toList();
  }
}
