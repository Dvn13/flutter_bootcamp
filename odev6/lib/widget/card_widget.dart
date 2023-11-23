import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String imgUrl;
  final Color bordercolor;

  const CardWidget(
      {super.key, required this.imgUrl, required this.bordercolor});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: bordercolor)),
      ),
    );
  }
}
