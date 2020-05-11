import 'package:dotodo/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[500],
        title: Text("Do-ToDo"),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: RaisedButton(
            child: Text('Sign in as Guest'),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print("Error Signing On");
              } else {
                print('Signed In');
                print(result);
              }
            },
          )),
    );
  }
}
