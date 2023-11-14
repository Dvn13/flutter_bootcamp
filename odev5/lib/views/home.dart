import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String result = '';

  void _actions(String buttonText) {
    if (buttonText == '=') {
      calculateResult();
    } else if (buttonText == 'C') {
      clearResult();
    } else {
      setState(() {
        result += buttonText;
      });
    }
  }

  void calculateResult() {
    try {
      final resultList = result.split("+");
      final firstNumber = int.tryParse(resultList[0]) ?? 0.0;
      final secondNumber = int.tryParse(resultList[1]) ?? 0.0;

      var calculateResult = firstNumber + secondNumber;
      setState(() {
        result = calculateResult.toString();
      });
    } catch (e) {
      result = 'Error';
    }
  }

  void clearResult() {
    setState(() {
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [resultWidget(), buttonsWidget()],
      ),
    ));
  }

  Expanded resultWidget() {
    return Expanded(
        flex: 2,
        child: Container(
          color: Colors.deepOrange,
          child: buildResult(),
        ));
  }

  Align buildResult() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          result,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  Expanded buttonsWidget() {
    return Expanded(
        flex: 8,
        child: Container(
          color: Colors.deepPurple,
          child: Column(
            children: [
              buildButton(['7', '8', '9', 'C']),
              buildButton(['4', '5', '6', '+']),
              buildButton(['1', '2', '3', '=']),
              buildButton(['0', '', '', '']),
            ],
          ),
        ));
  }

  Widget buildButton(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons
            .map(
              (buttonText) => Expanded(
                child: TextButton(
                  onPressed:
                      buttonText != "" ? () => _actions(buttonText) : null,
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
