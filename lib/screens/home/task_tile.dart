import 'package:dotodo/models/task.dart';
import 'package:dotodo/services/categories.dart';
import 'package:flutter/material.dart';
import 'package:dotodo/services/edit_task.dart';

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
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: avatarColor(),
            child: Icon(
              Categories().getAvatarImage(task.category),
              color: Colors.black,
            ),
          ),
           title: Text('${task.title}'),
           

          trailing: IconButton(
            onPressed: () {
              print('Vertical Button');
              print(task);
//              _showSettingsPanel(); 
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

  Color avatarColor() {
    Color returnColor = Colors.green;

    if (task.priority.compareTo('low') == 0) returnColor = Colors.green;
    if (task.priority.compareTo('high') == 0) returnColor = Colors.yellow;
    if (task.priority.compareTo('critical') == 0) returnColor = Colors.red;
    return returnColor;
  }
}
