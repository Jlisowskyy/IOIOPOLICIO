import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/models/data_model.dart';
import 'package:frontend/models/poker_card.dart';
import 'package:frontend/models/poker_deck.dart';
import 'package:frontend/widgets/poker_game/action_button.dart';
import 'package:frontend/widgets/poker_game/player_avatar.dart';
import 'package:frontend/widgets/poker_game/poker_table_painter.dart';

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
          // Background poker table
          Positioned.fill(
            child: CustomPaint(
              painter: PokerTablePainter(),
            ),
          ),
          // Overlay for players and game details
          Positioned.fill(
            child: Column(
              children: [
                _buildPlayerSection(),
                const Spacer(),
                _buildPokerBoard(),
                const Spacer(),
                _buildActionSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          PlayerAvatar(
              playerName: 'Player 1', avatarPath: AppDataModel.player1),
          PlayerAvatar(
              playerName: 'Player 2', avatarPath: AppDataModel.player2),
        ],
      ),
    );
  }

  Widget _buildPokerBoard() {
    final deck = PokerDeck.getDeck();
    final communityCards = deck.take(5).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.8),
        // borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Pot: \$500',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var card in communityCards) ...[
                SizedBox(
                  width: 50,
                  height: 70,
                  child: SvgPicture.asset(card.assetPath),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ActionButton(
            label: 'Fold',
            color: Colors.red,
            onPressed: () {},
          ),
          ActionButton(
            label: 'Check',
            color: Colors.grey,
            onPressed: () {},
          ),
          ActionButton(
            label: 'Raise',
            color: Colors.green,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
