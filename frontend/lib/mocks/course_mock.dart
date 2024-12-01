import '../models/course_model.dart';

const List<CourseModel> courses = [
  CourseModel(
    id: "poker101",
    title: "Poker Fundamentals",
    description:
        "Start your poker journey with essential concepts, basic rules, and fundamental strategies that every player needs to master.",
    durationMinutes: 120,
    difficulty: CourseDifficulty.beginner,
    imageUrl: "assets/poker101.jpg",
    prerequisites: [],
    topics: ["Basic Rules", "Hand Rankings", "Position Play", "Starting Hands"],
    studentsEnrolled: 1542,
    rating: 4.8,
    instructor: "Daniel Jones",
    completed: true,
  ),
  CourseModel(
    id: "math101",
    title: "Essential Poker Mathematics",
    description:
        "Master the critical mathematical concepts that form the foundation of profitable poker play.",
    durationMinutes: 180,
    difficulty: CourseDifficulty.beginner,
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
    completed: true,
  ),
  CourseModel(
    id: "tournament101",
    title: "Tournament Strategy Basics",
    description:
        "Learn how to navigate poker tournaments with confidence and precision.",
    durationMinutes: 240,
    difficulty: CourseDifficulty.intermediate,
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
    completed: false,
  ),
  CourseModel(
    id: "mental101",
    title: "Mental Game Mastery",
    description:
        "Develop unshakeable mental strength and emotional control for peak performance.",
    durationMinutes: 150,
    difficulty: CourseDifficulty.allLevels,
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
    completed: false,
  ),
  CourseModel(
    id: "cash201",
    title: "Advanced Cash Game Strategy",
    description:
        "Take your cash game to the next level with sophisticated strategies and advanced concepts.",
    durationMinutes: 300,
    difficulty: CourseDifficulty.advanced,
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
    completed: false,
  ),
  CourseModel(
    id: "gto301",
    title: "GTO Theory & Application",
    description:
        "Deep dive into Game Theory Optimal play and its practical applications.",
    durationMinutes: 360,
    difficulty: CourseDifficulty.expert,
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
    completed: false,
  ),
];
