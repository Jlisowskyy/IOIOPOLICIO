import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/poker_theme.dart';

// // Theme Configuration
// final ThemeData sportsPokerTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: Colors.red[900]!, // Deep red as the primary color
//   colorScheme: ColorScheme(
//     brightness: Brightness.dark,
//     primary: Colors.red[900]!, // Matches the dominant red tones
//     onPrimary: Colors.white, // Text on primary buttons
//     secondary: Colors.amber[600]!, // Golden yellow for accents
//     onSecondary: Colors.black, // Text on secondary elements
//     surface: Color(0xFF1A1A1A), // Slightly lighter than black for card surfaces
//     onSurface: Colors.white, // Text on surface
//     error: Colors.redAccent, // Error colors
//     onError: Colors.white, // Text for error messages
//     background: Colors.black,
//     onBackground: Colors.white,
//   ),
//   scaffoldBackgroundColor: Colors.black, // Matches the dark background
//   textTheme: TextTheme(
//     displayLarge: const TextStyle(
//       color: Colors.white,
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//     ),
//     bodyLarge: TextStyle(
//         color: Colors.grey[300], fontSize: 16, fontWeight: FontWeight.bold),
//     bodyMedium: TextStyle(
//         color: Colors.grey[400], fontSize: 14, fontWeight: FontWeight.bold),
//   ),
//   buttonTheme: ButtonThemeData(
//     buttonColor: Colors.red[900], // Red for call-to-action buttons
//     textTheme: ButtonTextTheme.primary,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: Colors.red[900],
//     foregroundColor: Colors.white,
//     elevation: 0,
//     titleTextStyle: const TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// );

// Main App
class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Poker Platform Admin',
        theme: sportsPokerTheme, // Apply Sports Poker Theme
        home: AdminDashboardScreen(),
      ),
    );
  }
}

// Dashboard Screen
class AdminDashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      drawer: AdminDrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMetricCard(
                  'Active Players', '1,234', Icons.people, context),
              _buildMetricCard(
                  'Ongoing Games', '42', Icons.gamepad, context),
              _buildMetricCard(
                  'Total Users', '5,678', Icons.supervisor_account, context),
              _buildRecentReportsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
        title: Text(title,
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold)),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentReportsSection(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Recent Reports',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          ListTile(
            title: Text('Suspicious Activity Detected',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color)),
            subtitle: Text('User: @player123',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color)),
            trailing: Text('2 hours ago',
                style: TextStyle(color: Colors.grey[600])),
          ),
          ListTile(
            title: Text('Game Violation',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color)),
            subtitle: Text('Game ID: #5678',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color)),
            trailing:
                Text('Today', style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}

// Admin Drawer Menu
class AdminDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    child: Icon(Icons.admin_panel_settings,
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Admin Control Panel',
                    style: Theme.of(context)
                        .appBarTheme
                        .titleTextStyle
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => AdminDashboardScreen())),
              context: context,
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'Player Management',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PlayerManagementScreen())),
              context: context,
            ),
            _buildDrawerItem(
              icon: Icons.gamepad,
              title: 'Game Management',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => GameManagementScreen())),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      onTap: onTap,
    );
  }
}

// Placeholder Screens
class PlayerManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player Management')),
      body: const Center(child: Text('Player Management Screen')),
    );
  }
}

class GameManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Management')),
      body: const Center(child: Text('Game Management Screen')),
    );
  }
}
