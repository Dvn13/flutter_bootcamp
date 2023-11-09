import 'package:flutter/material.dart';
import 'package:odev4/views/pageB_view.dart';
import 'package:odev4/widget/custom_text_button.dart';

class PageAView extends StatelessWidget {
  const PageAView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayfa A'),
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
                  text: 'Sayfa B',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PageBView()));
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
