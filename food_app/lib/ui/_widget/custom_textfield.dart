import 'package:flutter/material.dart';
import 'package:food_app/const/color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.text,
    this.control,
    this.icon,
    this.isPassword = false,
    this.keyboardType,
    this.onChanged,
    this.readOnly = false,
  });
  final String text;
  final IconData? icon;
  final TextEditingController? control;
  final void Function(String)? onChanged;
  final bool isPassword;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: ConstColor.primary,
          border: Border.all(color: ConstColor.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            if (icon != null) fieldIcon() else Container(),
            const SizedBox(width: 5),
            field(),
          ],
        ));
  }

  Padding fieldIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Icon(
        icon,
        color: ConstColor.white,
      ),
    );
  }

  Expanded field() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: TextFormField(
          autocorrect: false,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: control,
          obscureText: isPassword,
          readOnly: readOnly,
          style: const TextStyle(color: ConstColor.white),
          validator: (value) {
            return null;
          },
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: const TextStyle(color: ConstColor.white),
          ),
        ),
      ),
    );
  }
}
