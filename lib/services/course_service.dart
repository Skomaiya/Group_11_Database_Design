import 'dart:convert';
import 'package:flutter/services.dart';

class CourseService {
  /// Loads the courses from the local JSON file
  static Future<List<dynamic>> loadCourses() async {
    try {
      // Load the JSON file from the assets folder
      final String response = await rootBundle.loadString('assets/course.json');
      final data = json.decode(response);
      return data; // Return the parsed list of courses
    } catch (e) {
      throw Exception('Failed to load course data: $e');
    }
  }
}
