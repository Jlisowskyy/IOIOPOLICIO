import 'package:flutter/material.dart';

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String duration;
  final String difficulty;
  final String imageUrl;
  final List<String> prerequisites;
  final List<String> topics;
  final int studentsEnrolled;
  final double rating;
  final String instructor;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.difficulty,
    required this.imageUrl,
    required this.prerequisites,
    required this.topics,
    required this.studentsEnrolled,
    required this.rating,
    required this.instructor,
  });
}

class CourseListPage extends StatelessWidget {
  CourseListPage({super.key});

  final List<CourseModel> courses = [
    CourseModel(
      id: "poker101",
      title: "Poker Fundamentals",
      description:
          "Start your poker journey with essential concepts, basic rules, and fundamental strategies that every player needs to master.",
      duration: "2 hours",
      difficulty: "Beginner",
      imageUrl: "assets/poker101.jpg",
      prerequisites: [],
      topics: [
        "Basic Rules",
        "Hand Rankings",
        "Position Play",
        "Starting Hands"
      ],
      studentsEnrolled: 1542,
      rating: 4.8,
      instructor: "Daniel Jones",
    ),
    CourseModel(
      id: "math101",
      title: "Essential Poker Mathematics",
      description:
          "Master the critical mathematical concepts that form the foundation of profitable poker play.",
      duration: "3 hours",
      difficulty: "Beginner",
      imageUrl: "assets/math101.jpg",
      prerequisites: ["poker101"],
      topics: [
        "Pot Odds",
        "Equity Calculation",
        "Expected Value",
        "Break-Even Math"
      ],
      studentsEnrolled: 1123,
      rating: 4.7,
      instructor: "Sarah Chen",
    ),
    CourseModel(
      id: "tournament101",
      title: "Tournament Strategy Basics",
      description:
          "Learn how to navigate poker tournaments with confidence and precision.",
      duration: "4 hours",
      difficulty: "Intermediate",
      imageUrl: "assets/tournament101.jpg",
      prerequisites: ["poker101", "math101"],
      topics: [
        "Tournament Stages",
        "Stack Management",
        "Bubble Play",
        "Final Table Dynamics"
      ],
      studentsEnrolled: 892,
      rating: 4.9,
      instructor: "Mike Wilson",
    ),
    CourseModel(
      id: "mental101",
      title: "Mental Game Mastery",
      description:
          "Develop unshakeable mental strength and emotional control for peak performance.",
      duration: "2.5 hours",
      difficulty: "All Levels",
      imageUrl: "assets/mental101.jpg",
      prerequisites: [],
      topics: [
        "Tilt Control",
        "Mindset Training",
        "Performance Psychology",
        "Decision Making"
      ],
      studentsEnrolled: 2341,
      rating: 4.9,
      instructor: "Dr. Emma Thompson",
    ),
    CourseModel(
      id: "cash201",
      title: "Advanced Cash Game Strategy",
      description:
          "Take your cash game to the next level with sophisticated strategies and advanced concepts.",
      duration: "5 hours",
      difficulty: "Advanced",
      imageUrl: "assets/cash201.jpg",
      prerequisites: ["poker101", "math101"],
      topics: [
        "Range Construction",
        "Exploitative Play",
        "Game Selection",
        "Bankroll Management"
      ],
      studentsEnrolled: 645,
      rating: 4.6,
      instructor: "Alex Rodriguez",
    ),
    CourseModel(
      id: "gto301",
      title: "GTO Theory & Application",
      description:
          "Deep dive into Game Theory Optimal play and its practical applications.",
      duration: "6 hours",
      difficulty: "Expert",
      imageUrl: "assets/gto301.jpg",
      prerequisites: ["poker101", "math101", "cash201"],
      topics: [
        "GTO Fundamentals",
        "Solver Usage",
        "Mixed Strategies",
        "Population Tendencies"
      ],
      studentsEnrolled: 421,
      rating: 4.8,
      instructor: "Prof. James Matthews",
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
              const Color(0xFF1A237E),
              const Color(0xFF0D47A1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Master the Game",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Expert-curated courses to elevate your poker game",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue[100],
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) => CourseCard(
                  course: courses[index],
                  allCourses: courses,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final CourseModel course;
  final List<CourseModel> allCourses;

  const CourseCard({
    super.key,
    required this.course,
    required this.allCourses,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: isHovered
            ? (Matrix4.identity()..translate(0, -8, 0))
            : Matrix4.identity(),
        child: Card(
          elevation: isHovered ? 16 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: InkWell(
            onTap: () {
              // Handle course selection
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildDifficultyBadge(widget.course.difficulty),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.course.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  if (widget.course.prerequisites.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildPrerequisites(),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.access_time,
                        widget.course.duration,
                        Colors.blue[50]!,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        Icons.people,
                        "${widget.course.studentsEnrolled}",
                        Colors.green[50]!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color badgeColor;
    switch (difficulty.toLowerCase()) {
      case "beginner":
        badgeColor = Colors.green;
        break;
      case "intermediate":
        badgeColor = Colors.blue;
        break;
      case "advanced":
        badgeColor = Colors.orange;
        break;
      case "expert":
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor.withOpacity(0.5)),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPrerequisites() {
    List<String> prerequisiteTitles =
        widget.course.prerequisites.map((prereqId) {
      return widget.allCourses
          .firstWhere((course) => course.id == prereqId)
          .title;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prerequisites:",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          prerequisiteTitles.join(", "),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
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
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
