import 'package:flutter/material.dart';

class CourseModel {
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final String imageUrl;

  CourseModel({
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.imageUrl,
  });
}

class CourseListPage extends StatelessWidget {
  CourseListPage({super.key});

  final List<CourseModel> courses = [
    CourseModel(
      title: "Fundamentals of Tournament Poker Strategy",
      description:
          "Master the essential concepts of tournament poker including position play, stack sizes, and ICM considerations.",
      duration: "2.5 hours",
      difficulty: "Beginner",
      imageUrl: "https://placeholder.com/tournament-poker",
    ),
    CourseModel(
      title: "Advanced Cash Game Tactics",
      description:
          "Deep dive into sophisticated cash game strategies, including range construction and exploitative adjustments.",
      duration: "3 hours",
      difficulty: "Advanced",
      imageUrl: "https://placeholder.com/cash-game",
    ),
    CourseModel(
      title: "Mental Game Mastery",
      description:
          "Develop a strong mental game, learn tilt control, and maintain peak performance under pressure.",
      duration: "2 hours",
      difficulty: "Intermediate",
      imageUrl: "https://placeholder.com/mental-game",
    ),
    CourseModel(
      title: "GTO Principles & Applications",
      description:
          "Understanding game theory optimal play and how to implement it in your poker strategy.",
      duration: "4 hours",
      difficulty: "Advanced",
      imageUrl: "https://placeholder.com/gto",
    ),
    CourseModel(
      title: "Poker Math Made Simple",
      description:
          "Learn essential poker mathematics including pot odds, equity calculations, and expected value.",
      duration: "2 hours",
      difficulty: "Beginner",
      imageUrl: "https://placeholder.com/poker-math",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[900]!,
              Colors.grey[850]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  "Sport Poker Courses",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CourseCard(course: courses[index]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Handle course selection
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                course.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(
                    Icons.access_time,
                    course.duration,
                    Colors.blue[100]!,
                  ),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    Icons.trending_up,
                    course.difficulty,
                    Colors.green[100]!,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
