import 'package:flutter/material.dart';
import 'package:frontend/pages/course_list_page.dart';
import 'package:frontend/widgets/queue_manager.dart';
import '../models/data_model.dart';
import 'package:frontend/pages/user_profile_page.dart';
import 'package:frontend/pages/admin_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section with Gradient
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red[900]!,
                  Colors.red[800]!,
                ],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.casino,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  AppDataModel.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Navigation Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'MENU',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          // Navigation Buttons
          SidebarButton(
            title: "Play",
            icon: Icons.sports_esports,
            onTap: () {
              QueueManager.navigateToPokerGame(context);
            },
          ),
          SidebarButton(
            title: "Learn",
            icon: Icons.school,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CourseListPage()));
            },
          ),
          SidebarButton(
            title: "Profile",
            icon: Icons.person,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const UserProfilePage()));
            },
          ),
          SidebarButton(
            title: "Admin",
            icon: Icons.admin_panel_settings,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AdminPage()));
            },
          ),
          SidebarButton(
            title: "More",
            icon: Icons.more_horiz,
            onTap: () {},
          ),

          const Spacer(),

          // Bottom Auth Section
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border(
                top: BorderSide(
                  color: Colors.grey[800]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const SidebarButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  _SidebarButtonState createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<SidebarButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final hoverColor = Colors.red[700]!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: _isHovering ? hoverColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: _isHovering ? hoverColor : Colors.white,
            size: 24,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: _isHovering ? hoverColor : Colors.white,
              fontSize: 16,
              fontWeight: _isHovering ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          onTap: widget.onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
