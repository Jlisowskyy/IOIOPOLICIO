import 'package:flutter/material.dart';
import 'package:frontend/models/data_model.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'ExampleUser');
  final TextEditingController _emailController =
      TextEditingController(text: 'user@example.com');

  final Map<String, dynamic> userStats = {
    'totalPoints': 250,
    'rank': 'Intermediate',
    'nextRank': 'Advanced',
    'pointsToNextRank': 50,
    'totalRequiredPoints': 300,
    'badges': [
      {
        'name': 'First Game',
        'icon': Icons.star,
        'description': 'Completed first poker game'
      },
      {
        'name': 'Poker Strategy',
        'icon': Icons.extension,
        'description': 'Mastered basic poker strategies'
      }
    ],
    'courses': [
      {'title': 'Introduction to Poker', 'dateCompleted': '2024-01-15'},
      {'title': 'Intermediate Poker Strategies', 'dateCompleted': '2024-03-10'},
      {'title': 'Advanced Bluffing Techniques', 'dateCompleted': '2024-05-20'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('User Profile',
            style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Implement navigation to edit profile page or show dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section (Profile Picture + Username + Email)
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.cyan],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              const AssetImage(AppDataModel.profilePath),
                          backgroundColor: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _usernameController.text,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _emailController.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // User Statistics Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.leaderboard,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'User Statistics',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: userStats['totalPoints'] /
                          userStats['totalRequiredPoints'],
                      color: Colors.greenAccent,
                      backgroundColor: Colors.grey[300],
                      minHeight: 8,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${userStats['totalPoints']} / ${userStats['totalRequiredPoints']} points to ${userStats['nextRank']}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Badges Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.badge,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Badges',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: userStats['badges'].map<Widget>((badge) {
                        return Tooltip(
                          message: badge['description'],
                          child: Chip(
                            avatar: Icon(badge['icon'],
                                size: 16, color: Colors.white),
                            label: Text(badge['name'],
                                style: const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.teal,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Completed Courses Section
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.school,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Completed Courses',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: userStats['courses'].map<Widget>((course) {
                        return InkWell(
                          onTap: () {
                            // Navigate to course details or show a modal with more information
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.teal),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(course['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text(
                                      'Completed on: ${course['dateCompleted']}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
