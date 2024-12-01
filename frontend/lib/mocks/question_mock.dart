import '../models/question_model.dart';

const List<QuizQuestionModel> questionMocks = [
  QuizQuestionModel(
    question:
        "Which role is typically played in the bottom lane with a support?",
    options: ["Jungler", "ADC", "Mid laner", "Top laner"],
    correctOptionIndex: 1,
  ),
  QuizQuestionModel(
    question:
        "What is the name of the powerful neutral monster in the Baron pit?",
    options: ["Elder Drake", "Rift Herald", "Baron Nashor", "Blue Sentinel"],
    correctOptionIndex: 2,
  ),
  QuizQuestionModel(
    question: "Which summoner spell is most commonly used by junglers?",
    options: ["Ignite", "Teleport", "Flash", "Smite"],
    correctOptionIndex: 3,
  ),
  QuizQuestionModel(
    question: "What is the name of the first tower in each lane?",
    options: [
      "Outer Turret",
      "Inner Turret",
      "Inhibitor Turret",
      "Nexus Turret"
    ],
    correctOptionIndex: 0,
  ),
  QuizQuestionModel(
    question:
        "How many players are there in a standard League of Legends team?",
    options: ["3", "4", "5", "6"],
    correctOptionIndex: 2,
  ),
];
