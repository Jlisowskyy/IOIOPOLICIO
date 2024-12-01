import 'package:flutter/material.dart';
import 'package:frontend/widgets/queue_manager.dart';
import '../models/data_model.dart';
import 'package:frontend/pages/user_profile_page.dart';
import 'package:frontend/pages/admin_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: const Text(
              AppDataModel.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Navigation Buttons
          SidebarButton(
              title: "Play",
              icon: Icons.sports,
              onTap: () {
                QueueManager.navigateToPokerGame(context);
              }),
          SidebarButton(title: "Learn", icon: Icons.school, onTap: () {}),
          SidebarButton(
              title: "Profile",
              icon: Icons.people,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const UserProfilePage()));
              }),
          SidebarButton(
              title: "Admin",
              icon: Icons.admin_panel_settings,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AdminPage()));
              }),
          SidebarButton(title: "More", icon: Icons.more_horiz, onTap: () {}),
          const Spacer(),
          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.red,
                  // ),
                  child: const Text(
                    "Sign Up",
                  ),
                ),
                const Expanded(child: SizedBox(width: 16)),
                ElevatedButton(
                  onPressed: () {},
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.grey[800],
                  // ),
                  child: const Text(
                    "Log In",
                    // style: TextStyle(color: Colors.white)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SidebarButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const SidebarButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  _SidebarButtonState createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: ListTile(
        leading:
            Icon(widget.icon, color: _isHovering ? Colors.red : Colors.white),
        title: Text(widget.title,
            style: TextStyle(color: _isHovering ? Colors.red : Colors.white)),
        onTap: widget.onTap,
      ),
    );
  }
}
