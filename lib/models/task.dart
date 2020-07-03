class Task {
  String id;
  String title;
  String category;
  String priority;
  String parentID;

  Task({this.id, this.title, this.category, this.priority, this.parentID});

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'priority': priority,
        'parentID': parentID,
      };

  Task.fromJson(Map<String, dynamic> json, String taskID)
      : id = taskID ?? '',
        title = json['title'] ?? '',
        category = json['category'] ?? 'Task',
        priority = json['priority'] ?? 'low',
        parentID = json['parentID'] ?? '';
}
