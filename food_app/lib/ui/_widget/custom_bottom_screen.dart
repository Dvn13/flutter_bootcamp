import 'package:flutter/material.dart';
import 'package:food_app/ui/_widget/custom_button.dart';

class CustomBottomScreen extends StatelessWidget {
  const CustomBottomScreen({
    super.key,
    required this.textButton,
    required this.question,
  
    required this.onPressed,
    required this.questionPressed,
  });
  final String textButton;
  final String question;
 
  final void Function()? onPressed;
  final Function questionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  questionPressed();
                },
                child: Text(question),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: CustomButton(
            buttonText: textButton,
            width: 150,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}