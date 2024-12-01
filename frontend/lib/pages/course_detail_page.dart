import 'package:flutter/material.dart';

import '../models/course_model.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseModel course;
  final List<CourseModel> allCourses;

  const CourseDetailPage({
    super.key,
    required this.course,
    required this.allCourses,
  });

  @override
  Widget build(BuildContext context) {
    final isUnlocked = course.isUnlocked(allCourses);
    final missingPrerequisites = course.prerequisites.where((prereqId) {
      final prereq = allCourses.firstWhere((c) => c.id == prereqId);
      return !prereq.completed;
    }).map((prereqId) {
      return allCourses.firstWhere((c) => c.id == prereqId);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, isUnlocked),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: _buildContent(
                        context, isUnlocked, missingPrerequisites),
                  ),
                ),
              ],
            ),
          ),
          // Move navigation controls to a separate container to ensure proper z-index
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0),
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge(CourseDifficulty difficulty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: difficulty.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: difficulty.color.withOpacity(0.3)),
      ),
      child: Text(
        difficulty.displayName,
        style: TextStyle(
          color: difficulty.color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isUnlocked) {
    return Container(
      height: 400, // Increased height
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            course.difficulty.color.withOpacity(0.8),
            Colors.black,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                32, 100, 32, 32), // Increased top padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildDifficultyBadge(course.difficulty),
                    const Spacer(),
                    if (!isUnlocked)
                      _buildStatusBadge(
                        icon: Icons.lock,
                        text: "Prerequisites Required",
                        color: Colors.red,
                      )
                    else if (course.completed)
                      _buildStatusBadge(
                        icon: Icons.check_circle,
                        text: "Completed",
                        color: Colors.green,
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 56, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -1,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildInfoChip(Icons.person, course.instructor,
                        Colors.blue.withOpacity(0.2)),
                    const SizedBox(width: 12),
                    _buildInfoChip(Icons.access_time, course.formattedDuration,
                        Colors.green.withOpacity(0.2)),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                        Icons.people,
                        "${course.studentsEnrolled} enrolled",
                        Colors.purple.withOpacity(0.2)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isUnlocked,
      List<CourseModel> missingPrerequisites) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            "About this course",
            Text(
              course.description,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300],
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildSection(
            "What you'll learn",
            _buildTopicsList(course.topics),
          ),
          if (course.prerequisites.isNotEmpty) ...[
            const SizedBox(height: 40),
            _buildSection(
              "Prerequisites",
              _buildPrerequisitesList(missingPrerequisites),
            ),
          ],
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 400, // Increased width
              height: 60, // Increased height
              child: ElevatedButton(
                onPressed: isUnlocked
                    ? () {
                        // Handle course start
                      }
                    : () {
                        _showPrerequisitesDialog(context, missingPrerequisites);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isUnlocked ? course.difficulty.color : Colors.grey[800],
                  foregroundColor: Colors.white, // Explicitly set text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  isUnlocked ? "Start Course" : "Complete Prerequisites First",
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32, // Increased font size
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        content,
      ],
    );
  }

  Widget _buildTopicsList(List<String> topics) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: topics
          .map((topic) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: course.difficulty.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: course.difficulty.color.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  topic,
                  style: TextStyle(
                    color: course.difficulty.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildPrerequisitesList(List<CourseModel> missingPrerequisites) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: course.prerequisites.map((prereqId) {
        final prereq = allCourses.firstWhere((c) => c.id == prereqId);
        final isMissing = missingPrerequisites.contains(prereq);

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Icon(
                isMissing ? Icons.lock : Icons.check_circle,
                color: isMissing ? Colors.red : Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                prereq.title,
                style: TextStyle(
                  fontSize: 16,
                  color: isMissing ? Colors.red[300] : Colors.green[300],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  void _showPrerequisitesDialog(
      BuildContext context, List<CourseModel> missingPrerequisites) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 800,
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Complete Required Courses",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Complete these courses to unlock ${course.title}:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: missingPrerequisites
                            .map((prereq) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child:
                                      _buildPrerequisiteCard(context, prereq),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailPage(
                                course: missingPrerequisites.first,
                                allCourses: allCourses,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              missingPrerequisites.first.difficulty.color,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Start First Prerequisite",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrerequisiteCard(BuildContext context, CourseModel prereq) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailPage(
                course: prereq,
                allCourses: allCourses,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildDifficultyBadge(prereq.difficulty),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      prereq.formattedDuration,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                prereq.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                prereq.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        "${prereq.studentsEnrolled} enrolled",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(
                            course: prereq,
                            allCourses: allCourses,
                          ),
                        ),
                      );
                    },
                    child: const Text("View Course"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
