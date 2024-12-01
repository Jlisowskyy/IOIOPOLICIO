import 'package:flutter/material.dart';
import '../models/data_model.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AppDataModel.logoPath, height: 50),
          ),
          // Navigation Buttons
          const SidebarButton(title: "Play", icon: Icons.sports),
          const SidebarButton(title: "Puzzles", icon: Icons.extension),
          const SidebarButton(title: "Learn", icon: Icons.school),
          const SidebarButton(title: "Watch", icon: Icons.live_tv),
          const SidebarButton(title: "News", icon: Icons.article),
          const SidebarButton(title: "Social", icon: Icons.people),
          const SidebarButton(title: "More", icon: Icons.more_horiz),
          const Spacer(),
          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Sign Up"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  child: const Text("Log In"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const SidebarButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
