import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_app/screens/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TicTacToe Game',
      theme: ThemeData(
        textTheme: GoogleFonts.lobsterTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}
