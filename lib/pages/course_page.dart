import 'package:flutter/material.dart';
import 'package:sustanify/services/course_service.dart';
import 'package:sustanify/pages/course_detail.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      // Fetch courses using the CourseService
      final data = await CourseService.loadCourses();
      setState(() {
        courses = data;
      });
    } catch (e) {
      print('Error loading courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current theme mode
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define dynamic colors based on the theme
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color titleColor =
        isDarkMode ? Colors.tealAccent : const Color(0xFF146BB6);
    final Color descriptionColor = isDarkMode ? Colors.grey[400]! : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFF146BB6),
        title: const Text('Courses'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: backgroundColor, // Dynamic background color
        child: courses.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetailPage(course: course),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: cardColor, // Dynamic card color
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            // Course thumbnail or placeholder image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/course-image.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Course title and description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course['title'], // Course title
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: titleColor, // Dynamic title color
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    course['description'], // Course description
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          descriptionColor, // Dynamic description color
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
