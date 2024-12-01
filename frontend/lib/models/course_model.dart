import 'package:flutter/material.dart';

enum CourseDifficulty {
  beginner,
  intermediate,
  advanced,
  expert,
  allLevels;

  String get displayName {
    switch (this) {
      case CourseDifficulty.beginner:
        return 'Beginner';
      case CourseDifficulty.intermediate:
        return 'Intermediate';
      case CourseDifficulty.advanced:
        return 'Advanced';
      case CourseDifficulty.expert:
        return 'Expert';
      case CourseDifficulty.allLevels:
        return 'All Levels';
    }
  }

  Color get color {
    switch (this) {
      case CourseDifficulty.beginner:
        return Colors.green;
      case CourseDifficulty.intermediate:
        return Colors.blue;
      case CourseDifficulty.advanced:
        return Colors.orange;
      case CourseDifficulty.expert:
        return Colors.red;
      case CourseDifficulty.allLevels:
        return Colors.purple;
    }
  }
}

class CourseModel {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final CourseDifficulty difficulty;
  final String imageUrl;
  final List<String> prerequisites;
  final List<String> topics;
  final int studentsEnrolled;
  final double rating;
  final String instructor;
  final bool completed;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
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

  String get formattedDuration {
    final hours = durationMinutes ~/ 60;
    final minutes = durationMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return '${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${minutes}m';
    }
  }
}
