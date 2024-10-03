import 'package:flutter/material.dart';

class AssetsButtonFilter extends StatelessWidget {
  const AssetsButtonFilter({
    super.key,
    required this.text,
    required this.icon,
    required this.isActive,
    required this.onToggle,
  });

  final String text;
  final Icon icon;
  final bool isActive;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final buttonBackgroundColor =
        isActive ? const Color.fromARGB(255, 33, 136, 255) : Colors.white;
    final buttonIconColor =
        isActive ? Colors.white : const Color.fromARGB(255, 33, 136, 255);
    final buttonTextColor =
        isActive ? Colors.white : const Color.fromARGB(255, 33, 136, 255);

    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: Icon(
        icon.icon,
        color: buttonIconColor,
      ),
      label: Text(
        text,
        style: TextStyle(color: buttonTextColor),
      ),
      onPressed: onToggle,
    );
  }
}
