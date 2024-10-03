import 'package:flutter/material.dart';
import 'package:tractian_mobile_test/views/units_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TRACTIAN',
      home: UnitsScreen(),
    );
  }
}
