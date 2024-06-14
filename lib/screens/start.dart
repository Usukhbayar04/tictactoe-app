import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_app/constants/colors.dart';
import 'package:tictactoe_app/screens/game.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  static var customFontWhite = GoogleFonts.lobster(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GameScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tic-Tac-Toe Game',
              style: customFontWhite,
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              color: AppColor.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
