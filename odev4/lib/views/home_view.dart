import 'package:flutter/material.dart';
import 'package:odev4/views/pageA_view.dart';
import 'package:odev4/views/pageX_view.dart';
import 'package:odev4/widget/custom_text_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anasayfa'),
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
                  text: 'Sayfa A',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PageAView()));
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomTextButton(
                  text: 'Sayfa X',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PageXView()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
