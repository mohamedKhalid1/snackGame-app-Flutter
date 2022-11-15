import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.color,
      required this.press,
      required this.text});

  final Function() press;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      color: color,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
