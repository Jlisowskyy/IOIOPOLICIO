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
  final bool completed;

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
    required this.completed,
  });

  bool isUnlocked(List<CourseModel> allCourses) {
    if (prerequisites.isEmpty) return true;
    return prerequisites.every((prereqId) =>
        allCourses.firstWhere((course) => course.id == prereqId).completed);
  }
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
      completed: true, // Completed
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
      completed: true, // Completed
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
      completed: false, // Unlocked but not completed
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
      completed: false, // No prerequisites, always unlocked
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
      completed: false, // Unlocked (prerequisites completed)
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
      completed: false, // Locked (not all prerequisites completed)
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
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
                  color: Colors.grey[400],
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
    final bool isUnlocked = widget.course.isUnlocked(widget.allCourses);

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
          color: widget.course.completed
              ? Colors.grey[900]
              : (isUnlocked ? Colors.grey[850] : Colors.grey[900]),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: widget.course.completed
                  ? Colors.green.withOpacity(0.5)
                  : (isUnlocked
                      ? Colors.white.withOpacity(0.1)
                      : Colors.red.withOpacity(0.3)),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              if (!isUnlocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              InkWell(
                onTap: isUnlocked
                    ? () {
                        // Handle course selection
                      }
                    : null,
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
                          if (!isUnlocked)
                            const Icon(Icons.lock, color: Colors.red, size: 20)
                          else if (widget.course.completed)
                            const Icon(Icons.check_circle,
                                color: Colors.green, size: 20)
                          else
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  widget.course.rating.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.course.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: isUnlocked ? Colors.white : Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.course.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              isUnlocked ? Colors.grey[400] : Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const Spacer(),
                      if (widget.course.prerequisites.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _buildPrerequisites(isUnlocked),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildInfoChip(
                            Icons.access_time,
                            widget.course.duration,
                            Colors.blue.withOpacity(0.1),
                            textColor:
                                isUnlocked ? Colors.white : Colors.grey[500],
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            Icons.people,
                            "${widget.course.studentsEnrolled}",
                            Colors.green.withOpacity(0.1),
                            textColor:
                                isUnlocked ? Colors.white : Colors.grey[500],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
        border: Border.all(color: badgeColor.withOpacity(0.3)),
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

  Widget _buildPrerequisites(bool isUnlocked) {
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
            color: isUnlocked ? Colors.grey[400] : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          prerequisiteTitles.join(", "),
          style: TextStyle(
            fontSize: 12,
            color: isUnlocked ? Colors.grey[400] : Colors.grey[600],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color backgroundColor,
      {Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
