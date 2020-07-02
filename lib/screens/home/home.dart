import 'package:dotodo/models/task.dart';
import 'package:dotodo/models/user.dart';
import 'package:dotodo/screens/task/edit_task.dart';
import 'package:dotodo/screens/task/task_list.dart';
import 'package:dotodo/services/auth.dart';
import 'package:dotodo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//    debugPrint(user.uid);
    return StreamProvider<List<Task>>.value(
      value: DatabaseService(uid: user.uid,parentID: user.uid).tasks,
      child: Scaffold(
        appBar: buildAppBar(),
        body: TaskList(),
        floatingActionButton: buildFAB(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent[500],
      title: Text("Do-ToDo"),
      elevation: 0.0,
      actions: <Widget>[
        signOut(),
      ],
    );
  }

  FloatingActionButton buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        debugPrint('FAB clicked');
        SettingsPanel(Task(), context).showSettingsPanel();
//            navigateToDetail(Task('', '', ''), 'Add Task');
      },
      tooltip: 'Add Task',
      child: Icon(Icons.add),
    );
  }

  FlatButton signOut() {
    return FlatButton.icon(
      onPressed: () async {
        await _auth.signOut();
      },
      label: Text('LogOut'),
      icon: Icon(Icons.person_outline),
    );
  }
}
