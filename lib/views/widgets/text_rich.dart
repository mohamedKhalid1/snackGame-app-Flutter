import 'package:flutter/material.dart';

class TextRich extends StatelessWidget {
  const TextRich({
    super.key,
    required this.text1,
    required this.color1,
    required this.size1,
    required this.text2,
    required this.color2,
    required this.size2,
  });

  final String text1;
  final String text2;
  final Color color1;
  final Color color2;
  final double size1;
  final double size2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
          text: text1,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size1, color: color1),
          children: [
            TextSpan(
                text: text2,
                style: TextStyle(
                  color: color2,
                  fontSize: size2,
                )),
          ]),
    );
  }
}
