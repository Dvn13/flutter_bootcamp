import 'package:flutter/material.dart';
import 'package:odev4/views/pageY_view.dart';
import 'package:odev4/widget/custom_text_button.dart';

class PageXView extends StatelessWidget {
  const PageXView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page X'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: 'Sayfa Y',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PageYView()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
