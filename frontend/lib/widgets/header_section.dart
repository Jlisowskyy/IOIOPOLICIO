import 'package:flutter/material.dart';
import 'package:frontend/widgets/queue_manager.dart';

import '../models/data_model.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          AppDataModel.playHeader,
          style: TextStyle(
              color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          AppDataModel.playSubtext,
          style: TextStyle(color: Colors.grey, fontSize: 24),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                QueueManager.navigateToPokerGame(context);
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text(
                AppDataModel.playOnline,
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                QueueManager.navigateToPokerGame(context);
              },
              icon: const Icon(Icons.smart_toy),
              label: const Text(
                AppDataModel.playBots,
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        )
      ],
    );
  }
}
