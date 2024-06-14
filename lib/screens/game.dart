import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_app/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayOX = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  String resultDeclaration = '';
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  int attemps = 0;

  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;

  static var largeFont = GoogleFonts.lobster(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 54,
    ),
  );

  static var customFontWhite = GoogleFonts.lobster(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player 0',
                        style: customFontWhite,
                      ),
                      Text(
                        oScore.toString(),
                        style: customFontWhite,
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Player X',
                        style: customFontWhite,
                      ),
                      Text(
                        xScore.toString(),
                        style: customFontWhite,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: displayOX.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: AppColor.primaryColor,
                        ),
                        color: matchedIndexes.contains(index)
                            ? AppColor.accentColor
                            : AppColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(displayOX[index], style: largeFont),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultDeclaration,
                      style: customFontWhite,
                    ),
                    const SizedBox(height: 20),
                    _buildTimer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    final isRunnig = timer == null ? false : timer!.isActive;
    return isRunnig
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: 1 - seconds / maxSeconds,
                      valueColor:
                          AlwaysStoppedAnimation(AppColor.secondaryColor),
                      strokeWidth: 8,
                      backgroundColor: AppColor.accentColor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '$seconds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: () {
              _clearBoard();
              startTimer();
              attemps--;
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 15,
                )),
            child: Text(
              attemps == 0 ? 'Start' : 'Play again',
              style: TextStyle(
                fontSize: 20,
                color: AppColor.primaryColor,
              ),
            ),
          );
  }

  void _tapped(int index) {
    final isRunnig = timer == null ? false : timer!.isActive;

    if (isRunnig) {
      setState(() {
        if (oTurn && displayOX[index] == '') {
          displayOX[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayOX[index] == '') {
          displayOX[index] = 'X';
          filledBoxes++;
        }
        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // 1 row
    if (displayOX[0] == displayOX[1] &&
        displayOX[0] == displayOX[2] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[0]} Wins!';
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }
    // 2 row
    if (displayOX[3] == displayOX[4] &&
        displayOX[3] == displayOX[5] &&
        displayOX[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[3]} Wins!';
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayOX[3]);
      });
    }
    // 3 row
    if (displayOX[6] == displayOX[7] &&
        displayOX[6] == displayOX[8] &&
        displayOX[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[6]} Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayOX[6]);
      });
    }
    // 1 col
    if (displayOX[0] == displayOX[3] &&
        displayOX[0] == displayOX[6] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[0]} Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }
    // 2 col
    if (displayOX[1] == displayOX[4] &&
        displayOX[1] == displayOX[7] &&
        displayOX[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[1]} Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayOX[1]);
      });
    }
    // 3 col
    if (displayOX[2] == displayOX[5] &&
        displayOX[2] == displayOX[8] &&
        displayOX[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[2]} Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayOX[2]);
      });
    }
    // Dialog
    if (displayOX[0] == displayOX[4] &&
        displayOX[0] == displayOX[8] &&
        displayOX[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[0]} Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayOX[0]);
      });
    }
    // Dialog
    if (displayOX[2] == displayOX[4] &&
        displayOX[2] == displayOX[6] &&
        displayOX[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayOX[2]} Wins!';
        matchedIndexes.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayOX[6]);
      });
    } else if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Draw!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayOX[i] = '';
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
  }
}
