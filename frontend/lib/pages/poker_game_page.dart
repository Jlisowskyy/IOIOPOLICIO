import 'package:flutter/material.dart';
import 'package:frontend/models/data_model.dart';

class PokerGamePage extends StatefulWidget {
  @override
  _PokerGamePageState createState() => _PokerGamePageState();
}

class _PokerGamePageState extends State<PokerGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                AppDataModel.pokerBoardPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
