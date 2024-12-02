import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sustanify/models/event_model.dart';

class EventService {
  static Future<List<Event>> fetchEvents() async {
    final String response = await rootBundle.loadString('assets/events.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Event.fromJson(json)).toList();
  }
}
