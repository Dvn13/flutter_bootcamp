import 'package:flutter/material.dart';
import 'package:food_app/const/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed,
      this.width = 280});

  final String buttonText;
  final bool isOutlined;
  final void Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 4,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: isOutlined ? ConstColor.white : ConstColor.primary,
            border: Border.all(color: ConstColor.primary, width: 2.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isOutlined ? ConstColor.primary : ConstColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
