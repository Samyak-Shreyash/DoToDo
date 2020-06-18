import 'package:dotodo/models/task.dart';
import 'package:dotodo/screens/shared.dart';
import 'package:dotodo/screens/task/edit_task.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: SharedWidgets(task: task).buildAvatar(),
          title: Text('${task.title}'),
          trailing: IconButton(
            onPressed: () {
              print('Vertical Button');
              SettingsPanel(task, context).showSettingsPanel();
            },
            icon: Icon(Icons.more_vert),
          ),
          onTap: () {
            print('Tapped');
          },
          onLongPress: () {
            print('LongPress');
          },
          isThreeLine: false,
        ),
      ),
    );
  }
}
