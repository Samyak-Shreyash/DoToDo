import 'package:dotodo/models/task.dart';
import 'package:flutter/material.dart';
import 'package:dotodo/services/edit_task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
//    void _showSettingsPanel() {
//      print('Wow, in the same function');
//      showModalBottomSheet(
//          context: context,
//          builder: (context) {
//            return Container(
//              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//              child: Text(task.taskName),
//            );
//          });
//    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: avatarColor(),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
          title: Text('${task.taskName}'),
          trailing: IconButton(
            onPressed: () {
              print('Vertical Button');
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
