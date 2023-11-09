import 'package:flutter/material.dart';
import 'package:odev4/views/home_view.dart';

class PageYView extends StatelessWidget {
  const PageYView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeView()),
            (Route<dynamic> route) => false);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sayfa Y'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Sayfa Y'),
        ),
      ),
    );
  }
}
