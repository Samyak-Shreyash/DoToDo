import 'package:dotodo/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[500],
        title: Text("Do-ToDo"),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async
            {
              await _auth.signOut();
            },
            label: Text('LogOut'),
            icon: Icon(Icons.people),
          ),
        ],
      ),
    );
  }
}
