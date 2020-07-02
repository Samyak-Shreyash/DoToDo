import 'package:dotodo/models/task.dart';
import 'package:dotodo/screens/shared.dart';
import 'package:dotodo/screens/task/edit_task.dart';
import 'package:dotodo/models/user.dart';
import 'package:dotodo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: SharedWidgets(task: task).buildAvatar(),
          title: Text('${task.title}'),
          trailing: IconButton(
            onPressed: () {
              debugPrint('Delete');
              DatabaseService(uid:user.uid).deleteTask(task.id);
            },
            icon: Icon(Icons.delete),
          ),
          onTap: () {
            print('TapPed');
            SettingsPanel(task, context).showSettingsPanel();
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
