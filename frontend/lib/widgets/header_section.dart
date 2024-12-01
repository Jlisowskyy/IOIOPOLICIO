import 'package:flutter/material.dart';
import 'package:frontend/widgets/queue_manager.dart';

import '../models/data_model.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.red, Colors.redAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              AppDataModel.playHeader,
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppDataModel.playSubtext,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 24,
              letterSpacing: 0.5,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPlayButton(
                context: context,
                icon: Icons.play_arrow_rounded,
                label: AppDataModel.playOnline,
                isPrimary: true,
                onPressed: () {
                  QueueManager.navigateToPokerGame(context);
                },
              ),
              const SizedBox(width: 20),
              _buildPlayButton(
                context: context,
                icon: Icons.smart_toy_rounded,
                label: AppDataModel.playBots,
                isPrimary: false,
                onPressed: () {
                  QueueManager.navigateToPokerGame(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPlayButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 28,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(label),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.red : Colors.grey[900],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 20,
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: Colors.grey[800]!,
                    width: 1,
                  ),
          ),
        ),
      ),
    );
  }
}
