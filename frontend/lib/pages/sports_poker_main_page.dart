import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/header_section.dart';
import '../widgets/ad_banner.dart';

class SportsPokerMainPage extends StatelessWidget {
  const SportsPokerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HeaderSection(),
                  AdBanner(),
                  // Add more sections as needed
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
