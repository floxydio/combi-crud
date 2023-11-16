class TodoModel {
  final int id;
  final String activity;
  final String description;
  final String time;
  final String day;
  final int isDone;

  TodoModel(
      {this.id = 0,
      required this.activity,
      required this.description,
      required this.time,
      required this.day,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'activity': activity,
      'description': description,
      'time': time,
      'day': day,
      'isDone': isDone,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'activity': activity,
      'description': description,
      'time': time,
      'day': day,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['_id'],
        activity: json['activity'],
        description: json['description'],
        time: json['time'],
        day: json['day'],
        isDone: json['isDone']);
  }
}
