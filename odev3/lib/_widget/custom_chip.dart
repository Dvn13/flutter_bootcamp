import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color? bcColor;
  final Color? textColor;
  const CustomChip(
      {super.key, required this.text, this.bcColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(backgroundColor: bcColor),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
