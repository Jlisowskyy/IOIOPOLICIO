import 'package:flutter/material.dart';
import 'package:frontend/pages/sports_poker_main_page.dart';
import 'package:frontend/poker_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportsPoker.com',
      theme: sportsPokerTheme,
      home: const SportsPokerMainPage(),
    );
  }
}
