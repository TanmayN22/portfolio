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
  bool isGamePaused = false;
  bool isGameRunning = false;

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
    if (!isGameRunning) {
      gameTimer?.cancel();
      setState(() {
        isGameRunning = true;
        isGamePaused = false;
      });
      const duration = Duration(milliseconds: 300);
      gameTimer = Timer.periodic(duration, (Timer timer) {
        updateSnake();
        if (gameOver()) {
          timer.cancel();
          setState(() {
            isGameRunning = false;
            isGamePaused = false;
          });
          _showGameOver();
        }
      });
    }
  }

  // reset game to inital position
  void resetGame() {
    gameTimer?.cancel();

    setState(() {
      // Reset snake to initial position
      int startRow = 10;
      int startCol = random.nextInt(15) + 2;
      int startPos = startCol + startRow * 20;
      snakePosition = [startPos, startPos + 1];

      // Generate new food position
      foodPosition = foodRandomPosition();

      // Reset direction and game state
      direction = 'down';
      isGameRunning = false;
      isGamePaused = false;
    });
  }

  // game over
  bool gameOver() {
    for (int i = 0; i < snakePosition.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePosition.length; j++) {
        if (snakePosition[i] == snakePosition[j]) {
          count += 1;
        }
      }
      if (count == 2) {
        return true;
      }
    }
    return false;
  }

  // game over box
  void _showGameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You\'re score:${snakePosition.length - 2}'),
          actions: [
            TextButton(
              onPressed: () {
                resetGame();
                startGame();
                Navigator.pop(context);
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
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
        case LogicalKeyboardKey.space: // Spacebar to pause/resume
          if (isGameRunning) {
            pauseGame();
          } else if (isGamePaused) {
            resumeGame();
          }
          break;
      }
    }
  }

  void pauseGame() {
    if (gameTimer != null && isGameRunning) {
      gameTimer!.cancel();
      setState(() {
        isGamePaused = true;
        isGameRunning = false;
      });
    }
  }

  void resumeGame() {
    if (isGamePaused) {
      setState(() {
        isGamePaused = false;
        isGameRunning = true;
      });
      // Restart the timer with current game state
      const duration = Duration(milliseconds: 300);
      gameTimer = Timer.periodic(duration, (Timer timer) {
        updateSnake();
        if (gameOver()) {
          timer.cancel();
          setState(() {
            isGameRunning = false;
            isGamePaused = false;
          });
          _showGameOver();
        }
      });
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      height: 350,
                      width: 350,
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
                            squareColor = isDark ? Colors.white : Colors.black;
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

                    // Control buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isGameRunning && !isGamePaused)
                          TextButton(
                            onPressed: () {
                              resetGame();
                              startGame();
                            },
                            child: Text('Start'),
                          ),

                        if (isGameRunning)
                          TextButton(
                            onPressed: pauseGame,
                            child: Text('Pause'),
                          ),

                        if (isGamePaused)
                          TextButton(
                            onPressed: resumeGame,
                            child: Text('Resume'),
                          ),

                        SizedBox(width: 10),

                        if (isGameRunning || isGamePaused)
                          TextButton(
                            onPressed: () {
                              resetGame();
                            },
                            child: Text('Reset'),
                          ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Score display
                    Text(
                      'Score: ${snakePosition.length - 2}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    if (isGamePaused)
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'PAUSED - Press Space or Resume to continue',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    SizedBox(height: 20),
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
