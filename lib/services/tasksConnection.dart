import 'dart:convert';
import 'package:dotodo/models/task.dart';
import 'package:http/http.dart';

class TasksConnection
{
  static Task getTask(Map<String, dynamic> json) {
//    print(json);
//    print(json['title']);
    String _title=json['data']['title']??' ';
    String _category=json['data']['category']??'task';
    String _priority=json['data']['priority']??'low';

    Task _currentTask= new Task(title: _title,priority: _priority,category: _category);

    return _currentTask;
  }

  static Future browse(_url, {status='important'}) async {
    try{
      Response response = await get(_url);
      List collection = json.decode(response.body);
      List<Task> _tasks= collection.map((json) => getTask(json)).toList();
      // print(_tasks);
      return _tasks;
    }
    catch(e)
    {
      return null;
    }
  }
}