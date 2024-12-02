import 'package:flutter/material.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // Retrieve the current brightness (dark or light mode)
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define colors based on the theme
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color titleColor =
        isDarkMode ? Colors.tealAccent : const Color(0xFF146BB6);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF146BB6),
        title: const Text('Course Details'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor, // Dynamic background color
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['title'], // Course title
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: titleColor, // Dynamic title color
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course['description'], // Course description
                style: TextStyle(
                  fontSize: 16,
                  color: textColor, // Dynamic text color
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Content:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor, // Dynamic text color
                ),
              ),
              const SizedBox(height: 10),
              Text(
                course['content'], // Course content
                style: TextStyle(
                  fontSize: 16,
                  color: textColor, // Dynamic text color
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Duration: ${course['duration']}', // Course duration
                style: TextStyle(
                  fontSize: 16,
                  color: textColor, // Dynamic text color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
