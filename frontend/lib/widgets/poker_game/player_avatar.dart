import 'package:flutter/material.dart';

class PlayerAvatar extends StatelessWidget {
  final String playerName;
  final String avatarPath;

  const PlayerAvatar({
    Key? key,
    required this.playerName,
    required this.avatarPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(avatarPath),
        ),
        const SizedBox(height: 8),
        Text(
          playerName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
