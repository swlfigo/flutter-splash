import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaceHolderWidget extends StatelessWidget {
  final String imagePath;
  const PlaceHolderWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(imagePath),
    );
  }
}
