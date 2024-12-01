import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../mocks/question_mock.dart';
import '../models/course_model.dart';

class CourseStartPage extends StatefulWidget {
  final CourseModel course;

  const CourseStartPage({
    super.key,
    required this.course,
  });

  @override
  State<CourseStartPage> createState() => _CourseStartPageState();
}

class _CourseStartPageState extends State<CourseStartPage>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  bool _showQuiz = false;
  bool _quizCompleted = false;
  int _currentQuestionIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    _controller.loadVideoById(videoId: '7lxvb3GOdNc');

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.course.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayer(
                      controller: _controller,
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (!_showQuiz && !_quizCompleted)
                    _buildStartQuizButton()
                  else if (_showQuiz && !_quizCompleted)
                    _buildQuizSection()
                  else
                    _buildCompletionSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartQuizButton() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        children: [
          const Text(
            "Ready to Test Your Knowledge?",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Complete the quiz to earn your exclusive reward",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => setState(() => _showQuiz = true),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.course.difficulty.color,
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 24,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Start Quiz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizSection() {
    final currentQuestion = questionMocks[_currentQuestionIndex];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Question ${_currentQuestionIndex + 1}/${questionMocks.length}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            currentQuestion.question,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ...currentQuestion.options.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildAnswerOption(
                    entry.value,
                    entry.key,
                    currentQuestion.correctOptionIndex,
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(String option, int index, int correctIndex) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (index == correctIndex) {
            if (_currentQuestionIndex < questionMocks.length - 1) {
              setState(() => _currentQuestionIndex++);
            } else {
              setState(() {
                _showQuiz = false;
                _quizCompleted = true;
              });
            }
          } else {
            _showWrongAnswerDialog();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          option,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showWrongAnswerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Incorrect Answer",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Starting over from question 1",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _currentQuestionIndex = 0);
            },
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Trophy animation
          Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_touohxv0.json',
            height: 200,
            repeat: true,
          ),
          const SizedBox(height: 24),
          // Animated congratulations text
          TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.green, Colors.lime],
                  ).createShader(bounds),
                  child: const Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Fade-in text
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Text(
                  "You've completed the course and passed the quiz!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[300],
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    _animationController.dispose();
    super.dispose();
  }
}
