import 'dart:io';

import 'package:dotodo/models/task.dart';
import 'package:dotodo/screens/home/task_tile.dart';
import 'package:dotodo/services/taskManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
TaskManager manager= TaskManager();
    //      final tasks = Provider.of<List<Task>>(context);
      return StreamBuilder(
        stream: manager.TaskListNow,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<List<Task>> snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              List<Task>  tasks = snapshot.data;
              return ListView.builder(
                  itemCount: tasks?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
                  });
          }},
      );
  }
}