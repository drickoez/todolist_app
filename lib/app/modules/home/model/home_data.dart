class Task {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? time;
  final int? status;

  Task({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    this.status,
  });

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        date = map['date'],
        time = map['time'],
        status = map['status'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
