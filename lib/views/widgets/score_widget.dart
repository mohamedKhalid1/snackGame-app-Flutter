import 'package:flutter/material.dart';
import 'package:snack_game2/views/widgets/text_rich.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key, required this.highScore, required this.currentScore});

  final int currentScore;
  final List<int> highScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextRich(
              text1: "Current Score : ",
              color1: Colors.black,
              size1: 18,
              text2: "$currentScore",
              color2: const Color.fromARGB(255, 206, 22, 215),
              size2: 60),
        ),
        //const VerticalDivider(thickness: 2),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "High 5 Score",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TextRich(
                          text1: "${index + 1}.  ",
                          color1: Colors.black,
                          size1: 10,
                          text2: "${highScore[index]}",
                          color2: Colors.green,
                          size2: 16);
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
