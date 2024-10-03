import 'package:flutter/material.dart';

class UnitsButton extends StatelessWidget {
  const UnitsButton({super.key, required this.title, required this.function});

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(15),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromARGB(255, 33, 136, 255),
        ),
        child: TextButton.icon(
          onPressed: () {
            function();
          },
          icon: const Icon(Icons.build, color: Colors.white),
          label: Text(
            '$title Unit',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
