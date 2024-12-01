import 'package:flutter/material.dart';
import 'package:frontend/pages/admin_page.dart';
import 'package:frontend/pages/poker_game_page.dart';
import 'package:frontend/pages/sports_poker_main_page.dart';
import 'package:frontend/pages/user_profile_page.dart';
import 'package:frontend/poker_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportsPoker.com',
      theme: sportsPokerTheme,
<<<<<<< HEAD
      home: PokerGamePage(),
=======
      home: const UserProfilePage(),
>>>>>>> c73afcf (user profile colors update)
    );
  }
}
