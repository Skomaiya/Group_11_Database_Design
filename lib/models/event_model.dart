class Event {
  final int eventId;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;

  Event({
    required this.eventId,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['eventId'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
    );
  }
}
