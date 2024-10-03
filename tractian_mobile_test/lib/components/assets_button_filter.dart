import 'package:flutter/material.dart';

class AssetsButtonFilter extends StatefulWidget {
  const AssetsButtonFilter({
    super.key,
    required this.text,
    required this.icon,
    required this.function,
  });

  final String text;
  final Icon icon;
  final Function function;

  @override
  State<AssetsButtonFilter> createState() => _AssetsButtonFilterState();
}

class _AssetsButtonFilterState extends State<AssetsButtonFilter> {
  bool isActive = false;

  late Color buttonBackgroundColor;
  late Color buttonIconColor;
  late Color buttonTextColor;

  @override
  void initState() {
    super.initState();
    changeButtonColors(isActive);
  }

  void changeButtonColors(bool isActive) {
    setState(() {
      if (isActive) {
        buttonBackgroundColor = const Color.fromARGB(255, 33, 136, 255);
        buttonIconColor = Colors.white;
        buttonTextColor = Colors.white;
      } else {
        buttonBackgroundColor = Colors.white;
        buttonIconColor = const Color.fromARGB(255, 33, 136, 255);
        buttonTextColor = const Color.fromARGB(255, 33, 136, 255);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: buttonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: Icon(
        widget.icon.icon,
        color: buttonIconColor,
      ),
      label: Text(
        widget.text,
        style: TextStyle(color: buttonTextColor),
      ),
      onPressed: () {
        isActive = !isActive;
        changeButtonColors(isActive);
        widget.function();
      },
    );
  }
}
