import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:porfolio/app/controllers/home_controller.dart';
import 'package:porfolio/app/widgets/app_page_wrapper.dart';
import 'package:porfolio/app/widgets/custom_appbar.dart';
import 'dart:math';

class MiniGame extends StatefulWidget {
  const MiniGame({super.key});

  @override
  State<MiniGame> createState() => _MiniGameState();
}

class _MiniGameState extends State<MiniGame> {
  int numberOfSquares = 400;
  Random random = Random();
  late List<int> snakePosition;
  late int foodPosition;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    int startRow = 10;
    int startCol = random.nextInt(15) + 2;
    int startPos = startCol + startRow * 20;
    snakePosition = [startPos, startPos + 1];
    foodPosition = foodRandomPosition();
    focusNode.requestFocus();
  }

  // food position
  int foodRandomPosition() {
    int newPosition;
    do {
      newPosition = random.nextInt(numberOfSquares);
    } while (snakePosition.contains(newPosition));
    return newPosition;
  }

  void generateFood() {
    foodPosition = foodRandomPosition();
  }

  Timer? gameTimer;
  // disposing every thing that starts
  @override
  void dispose() {
    gameTimer?.cancel();
    focusNode.dispose();
    super.dispose();
  }

  // start game
  void startGame() {
    gameTimer?.cancel();
    const duration = Duration(milliseconds: 300);
    gameTimer = Timer.periodic(duration, (Timer timer) {
      updateSnake();
    });
  }

  // update snake position
  var direction = 'down';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last >= 380) {
            snakePosition.add(snakePosition.last % 20);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;

        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last + 380);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;

        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last + 19);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        case 'right':
          if (snakePosition.last % 20 == 19) {
            snakePosition.add(snakePosition.last - 19);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;

        default:
      }

      if (snakePosition.last == foodPosition) {
        generateFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  void handleKeyPress(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          if (direction != 'down') direction = 'up';
          break;
        case LogicalKeyboardKey.arrowDown:
          if (direction != 'up') direction = 'down';
          break;
        case LogicalKeyboardKey.arrowRight:
          if (direction != 'left') direction = 'right';
          break;
        case LogicalKeyboardKey.arrowLeft:
          if (direction != 'right') direction = 'left';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;

    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: handleKeyPress,
      child: AppPageWrapper(
        backgroundColor: backgroundColor,
        child: Column(
          children: [
            CustomAppBar(
              onBack: () => Get.find<HomeController>().closeApp(),
              appName: 'Mini Game',
              backgroundColor: Colors.black,
            ),
            Expanded(
              child: SingleChildScrollView(
                // Make it scrollable
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Changed from center
                  children: [
                    SizedBox(height: 20), // Top padding
                    SizedBox(
                      height: 350, // Reduce from 400 to 350
                      width: 350, // Reduce from 400 to 350
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: numberOfSquares,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          Color squareColor;
                          if (snakePosition.contains(index)) {
                            squareColor = Colors.red;
                          } else if (index == foodPosition) {
                            squareColor = Colors.white;
                          } else {
                            squareColor = Colors.grey;
                          }
                          return Container(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(color: squareColor),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () => startGame(),
                      child: Text('Start'),
                    ),
                    SizedBox(height: 20), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
