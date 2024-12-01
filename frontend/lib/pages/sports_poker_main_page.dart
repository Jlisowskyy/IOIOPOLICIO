import 'package:flutter/material.dart';

import '../widgets/header_section.dart';
import '../widgets/sidebar.dart';

class SportsPokerMainPage extends StatelessWidget {
  const SportsPokerMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ],
              stops: [0.0, 1.0],
            ).createShader(bounds),
            blendMode: BlendMode.darken,
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
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
