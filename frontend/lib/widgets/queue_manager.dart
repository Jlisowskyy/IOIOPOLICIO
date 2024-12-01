import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/pages/poker_game_page.dart';

class QueueManager {
  static void navigateToPokerGame(BuildContext context) async {
    // Show a short loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Simulate a short delay (e.g., 2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    // Dismiss the loading indicator
    Navigator.of(context).pop();

    // Show the accept popup with a timeout
    bool accepted = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Join Poker Game'),
              content: const Text('Do you want to join the poker game?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Accept'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Decline'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (accepted) {
      // Navigate to the PokerGame page
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PokerGamePage()),
      );
    }
  }
}
