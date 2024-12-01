import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header_section.dart';

class SportsPokerMainPage extends StatelessWidget {
  const SportsPokerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeaderSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
