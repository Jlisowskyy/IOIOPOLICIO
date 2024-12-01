import 'package:flutter/material.dart';

import '../mocks/course_mock.dart';
import '../models/course_model.dart';
import 'course_detail_page.dart';

class CourseListPage extends StatelessWidget {
  CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red[900]!,
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 32.0),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                onTap: true
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseDetailPage(
                              course: widget.course,
                              allCourses: widget.allCourses,
                            ),
                          ),
                        );
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
                            widget.course.formattedDuration,
                            Colors.red.withOpacity(0.1),
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
