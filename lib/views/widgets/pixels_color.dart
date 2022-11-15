import 'package:flutter/material.dart';

class PixelsColor extends StatelessWidget {
  const PixelsColor(this.color, {Key? key}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: color,
      ),
    );
  }
}
