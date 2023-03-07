import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snack_game2/views/widgets/button_widget.dart';
import 'package:snack_game2/views/widgets/pixels_color.dart';
import 'package:snack_game2/views/widgets/score_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

//enum of Snack Directions
enum SnackDirection { top, down, right, left }

class _HomeState extends State<Home> {
// any values
  List<int> snackPosition = [0, 1, 2];
  int foodValue = Random().nextInt(100);
  var currentDirection = SnackDirection.right;
  int rowSize = 10;
  int sumOfPixels = 100;
  int currentScore = 0;
  bool hasStarted = false;
  List<int> highScore = [0, 0, 0, 0, 0];
  int score = 0;
  int speed = 200;

  @override
  void initState() {
    // TODO: implement initState
    getHighScore();
    super.initState();
  }

  //any Functions

  //Function of Game over
  bool gameOver() {
    List bodySnack = snackPosition.sublist(0, snackPosition.length - 1);
    if (bodySnack.contains(snackPosition.last)) {
      return true;
    }
    return false;
  }

  //Function eat Food
  void eatFood() {
    if (snackPosition.last == foodValue) {
      currentScore++;
      foodValue = Random().nextInt(100);
    } else {
      snackPosition.remove(snackPosition[0]);
    }
  }

  //Function to move snack
  void moveSnack() {
    gameOver();
    eatFood();
    switch (currentDirection) {
      case SnackDirection.right:
        if (snackPosition.last % rowSize == 9) {
          snackPosition.add(snackPosition.last - rowSize + 1);
        } else {
          snackPosition.add(snackPosition.last + 1);
        }
        break;
      case SnackDirection.left:
        if (snackPosition.last % rowSize == 0) {
          snackPosition.add(snackPosition.last + rowSize - 1);
        } else {
          snackPosition.add(snackPosition.last - 1);
        }
        break;
      case SnackDirection.top:
        if (snackPosition.last < rowSize) {
          snackPosition.add(snackPosition.last + sumOfPixels - rowSize);
        } else {
          snackPosition.add(snackPosition.last - rowSize);
        }
        break;
      case SnackDirection.down:
        if (snackPosition.last + rowSize >= sumOfPixels) {
          snackPosition.add(snackPosition.last - sumOfPixels + rowSize);
        } else {
          snackPosition.add(snackPosition.last + rowSize);
        }
        break;
      //snackPosition.remove(snackPosition[0]);
    }
  }

  //Function to calculate high 5 score
  void high5Score() {
    if (highScore.contains(score)) {
    } else if (score > highScore[4]) {
      highScore[4] = score;
      highScore.sort();
      highScore = highScore.reversed.toList();
    }
  }

  // tow function with shared preference to save high scores of the same user
  void saveHigh5Score() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> saveStringHighScore =
        highScore.map((e) => e.toString()).toList();
    sharedPreferences.setStringList("high5Score", saveStringHighScore);
  }

  void getHighScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> getStringHighScore =
        sharedPreferences.getStringList("high5Score")!;
    highScore = getStringHighScore.map((e) => int.parse(e)).toList();
  }

  //Function of new game
  void newGame() {
    Navigator.pop(context);
    score = currentScore;
    high5Score();
    saveHigh5Score();
    currentScore = 0;
    snackPosition = [0, 1, 2];
    hasStarted = false;
    currentDirection = SnackDirection.right;
    foodValue = Random().nextInt(100);
  }

  //Function to Start Game
  void startGame() {
    hasStarted = true;
    Timer.periodic(Duration(milliseconds: speed), (timer) {
      setState(() {
        moveSnack();
        if (gameOver()) {
          timer.cancel();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Game over",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                content: Text(
                  "Score : $currentScore",
                  style: const TextStyle(
                    //color: Color.fromARGB(255, 206, 22, 215),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                actions: [
                  ButtonWidget(
                      color: Colors.green,
                      press: () {
                        setState(() {
                          newGame();
                        });
                      },
                      text: "Play again")
                ],
              );
            },
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: ScoreWidget(
                  currentScore: currentScore,
                  highScore: highScore,
                ),
              ),
              Expanded(
                flex: 6,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0 &&
                        currentDirection != SnackDirection.left) {
                      currentDirection = SnackDirection.right;
                    } else if (details.delta.dx < 0 &&
                        currentDirection != SnackDirection.right) {
                      currentDirection = SnackDirection.left;
                    }
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0 &&
                        currentDirection != SnackDirection.top) {
                      currentDirection = SnackDirection.down;
                    } else if (details.delta.dy < 0 &&
                        currentDirection != SnackDirection.down) {
                      currentDirection = SnackDirection.top;
                    }
                  },
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: sumOfPixels,
                    itemBuilder: (context, index) {
                      if (snackPosition.contains(index)) {
                        return const PixelsColor(Colors.white);
                      } else if (foodValue == index) {
                        return const PixelsColor(
                            Color.fromARGB(255, 7, 224, 25));
                      } else {
                        return const PixelsColor(Color(0xFF404040));
                      }
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: rowSize),
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                      color: hasStarted
                          ? Colors.grey
                          : const Color.fromARGB(255, 7, 224, 25),
                      press: () {
                        hasStarted ? () {} : startGame();
                      },
                      text: "PLAY"),
                  ButtonWidget(
                      color: Colors.greenAccent,
                      press: () {
                        if (speed != 160) {
                          speed = 160;
                        }
                      },
                      text: "X1"),
                  ButtonWidget(
                      color: Colors.greenAccent,
                      press: () {
                        if (speed != 120) {
                          speed = 120;
                          startGame();
                        }
                      },
                      text: "X2"),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
