import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
