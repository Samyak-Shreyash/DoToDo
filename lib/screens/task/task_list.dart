import 'package:dotodo/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///D:/Projects/FlutterApps/DoToDo/lib/screens/task/task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    if (tasks != null) {
      return ListView.builder(
        itemCount: tasks.length ?? 0,
        addAutomaticKeepAlives: false,
        itemBuilder: (context, index) {
          return TaskTile(task: tasks[index]);
        },
      );
    } else {
      return Container();
    }
  }
}
