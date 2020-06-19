import 'dart:async';
import 'package:dotodo/models/task.dart';
import 'package:dotodo/services/tasksConnection.dart';
class TaskManager {
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Stream<List<Task>> get TaskListNow async* {
    const String _url = 'https://us-central1-dotodo-web.cloudfunctions.net/app/tasks/notes';
    yield await  TasksConnection.browse(_url);
  }
  // ignore: close_sinks
  final StreamController<int> _taskCounter = StreamController<int>();
  Stream<int> get taskCounter =>_taskCounter.stream;

  TaskManager() {
    TaskListNow.listen((list) =>_taskCounter.add(list.length));
  }
}