import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Main App
class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Poker Platform Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            elevation: 1,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
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
      appBar: AppBar(title: Text('Admin Dashboard')),
      drawer: AdminDrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMetricCard('Active Players', '1,234', Icons.people),
              _buildMetricCard('Ongoing Games', '42', Icons.gamepad),
              _buildMetricCard(
                  'Total Users', '5,678', Icons.supervisor_account),
              _buildRecentReportsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildRecentReportsSection() {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Recent Reports',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          ListTile(
            title: Text('Suspicious Activity Detected'),
            subtitle: Text('User: @player123'),
            trailing: Text('2 hours ago', style: TextStyle(color: Colors.grey)),
          ),
          ListTile(
            title: Text('Game Violation'),
            subtitle: Text('Game ID: #5678'),
            trailing: Text('Today', style: TextStyle(color: Colors.grey)),
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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.admin_panel_settings, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'Admin Control Panel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => AdminDashboardScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'Player Management',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PlayerManagementScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.gamepad,
            title: 'Game Management',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => GameManagementScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.school,
            title: 'Course Management',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CourseManagementScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.analytics,
            title: 'Reporting',
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ReportingScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.badge,
            title: 'Badges',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BadgeManagementScreen())),
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'System Settings',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SystemSettingsScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

// Placeholder Screens (to demonstrate navigation)
class PlayerManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Management')),
      body: Center(child: Text('Player Management Screen')),
    );
  }
}

class GameManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Management')),
      body: Center(child: Text('Game Management Screen')),
    );
  }
}

class CourseManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Management')),
      body: Center(child: Text('Course Management Screen')),
    );
  }
}

class ReportingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reporting and Analytics')),
      body: Center(child: Text('Reporting Screen')),
    );
  }
}

class BadgeManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Badge Management')),
      body: Center(child: Text('Badge Management Screen')),
    );
  }
}

class SystemSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('System Settings')),
      body: Center(child: Text('System Settings Screen')),
    );
  }
}
