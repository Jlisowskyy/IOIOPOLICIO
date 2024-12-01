import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header_section.dart';

class SportsPokerMainPage extends StatelessWidget {
  const SportsPokerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          const Row(
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
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
