import 'package:flutter/material.dart';
import 'package:frontend/mocks/course_mock.dart';

import '../models/course_model.dart';

class CourseCreatorPage extends StatefulWidget {
  const CourseCreatorPage({super.key});

  @override
  State<CourseCreatorPage> createState() => _CourseCreatorPageState();
}

class _CourseCreatorPageState extends State<CourseCreatorPage> {
  final _formKey = GlobalKey<FormState>();
  CourseDifficulty _selectedDifficulty = CourseDifficulty.beginner;
  final List<String> _prerequisites = [];
  final List<String> _topics = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create New Course",
          style: TextStyle(
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
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 32),
                    _buildBasicInfoSection(),
                    const SizedBox(height: 32),
                    _buildContentSection(),
                    const SizedBox(height: 32),
                    _buildTopicsSection(),
                    const SizedBox(height: 32),
                    _buildPrerequisitesSection(),
                    const SizedBox(height: 48),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blue[800]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Course Creator Studio",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Create engaging content and share your knowledge with the community",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Basic Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _titleController,
              label: "Course Title",
              hint: "Enter course title",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _descriptionController,
              label: "Description",
              hint: "Enter course description",
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description is required";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDifficultyDropdown(),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _durationController,
              label: "Duration (minutes)",
              hint: "Enter course duration in minutes",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Duration is required";
                }
                if (int.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Course Content",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _youtubeUrlController,
              label: "YouTube Video URL",
              hint: "Enter YouTube video URL",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Video URL is required";
                }
                if (!value.contains('youtube.com') &&
                    !value.contains('youtu.be')) {
                  return "Please enter a valid YouTube URL";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicsSection() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Course Topics",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _topicController,
                    label: "Add Topic",
                    hint: "Enter a topic",
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_topicController.text.isNotEmpty) {
                      setState(() {
                        _topics.add(_topicController.text);
                        _topicController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Add Topic",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _topics
                  .map((topic) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              topic,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _topics.remove(topic);
                                });
                              },
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.blue[100],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrerequisitesSection() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Prerequisites",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Select from existing courses:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: courses
                  .map((course) => _buildPrerequisiteChip(course))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrerequisiteChip(CourseModel course) {
    final isSelected = _prerequisites.contains(course.id);
    return FilterChip(
      selected: isSelected,
      label: Text(course.title),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _prerequisites.add(course.id);
          } else {
            _prerequisites.remove(course.id);
          }
        });
      },
      backgroundColor: Colors.grey[800],
      selectedColor: Colors.blue.withOpacity(0.8),
      checkmarkColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey[300],
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: _isSubmitting
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "Create Course",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[850],
      ),
    );
  }

  Widget _buildDifficultyDropdown() {
    return DropdownButtonFormField<CourseDifficulty>(
      value: _selectedDifficulty,
      onChanged: (CourseDifficulty? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedDifficulty = newValue;
          });
        }
      },
      items: CourseDifficulty.values.map((difficulty) {
        return DropdownMenuItem<CourseDifficulty>(
          value: difficulty,
          child: Text(
            difficulty.displayName,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: "Difficulty Level",
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.grey[850],
      ),
      dropdownColor: Colors.grey[850],
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isSubmitting = false);

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            title: const Text(
              "Success!",
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              "Your course has been created successfully.",
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _youtubeUrlController.dispose();
    _topicController.dispose();
    super.dispose();
  }
}
