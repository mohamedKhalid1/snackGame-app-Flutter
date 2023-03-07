import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget(
      {super.key, required this.highScore, required this.currentScore});

  final int currentScore;
  final List<int> highScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "Current Score",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text("$currentScore",
                style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 35,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const Text(
          "High 5 Score ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(
                    "${highScore[index]} , ",
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
