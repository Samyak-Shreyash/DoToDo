class Task {

  String id;
  String title;
  String category;
  String priority;

  Task({this.id, this.title, this.category, this.priority});

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'category': category,
        'priority': priority,
      };

  Task.fromJson(Map<String, dynamic> json, String ID)
    : id = ID?? '',
    title = json['title']??'',
    category = json['category']??'Task',
    priority = json['priority']??'low';

}
