import 'package:flutter/material.dart';
import 'package:odev6/views/product/view/product_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Komagene',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const ProductView(),
    );
  }
}
