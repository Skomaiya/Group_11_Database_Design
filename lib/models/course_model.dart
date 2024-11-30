import 'dart:convert';

class Course {
  final int courseId;
  final String lessonId;
  final String title;
  final String description;
  final String content;
  final String duration;
  final String difficultyLevel;
  final List<String> topics;
  final List<Resource> resources;

  Course({
    required this.courseId,
    required this.lessonId,
    required this.title,
    required this.description,
    required this.content,
    required this.duration,
    required this.difficultyLevel,
    required this.topics,
    required this.resources,
  });

  // Factory method to create a Course from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'],
      lessonId: json['lessonId'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      duration: json['duration'],
      difficultyLevel: json['difficultyLevel'],
      topics: List<String>.from(json['topics']),
      resources: (json['resources'] as List)
          .map((resource) => Resource.fromJson(resource))
          .toList(),
    );
  }

  // Method to convert a Course to JSON
  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'lessonId': lessonId,
      'title': title,
      'description': description,
      'content': content,
      'duration': duration,
      'difficultyLevel': difficultyLevel,
      'topics': topics,
      'resources': resources.map((resource) => resource.toJson()).toList(),
    };
  }
}

class Resource {
  final String type;
  final String url;

  Resource({required this.type, required this.url});

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      type: json['type'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
    };
  }
}

// Method to parse a list of Courses from JSON
List<Course> parseCourses(String jsonString) {
  final List<dynamic> parsed = jsonDecode(jsonString);
  return parsed.map((json) => Course.fromJson(json)).toList();
}
