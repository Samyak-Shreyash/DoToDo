import 'package:dotodo/services/ValidationRules.dart';
import 'package:dotodo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //TODO: Set state variables
  String formPage = 'Sign-In';
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.cyan[200],

      //TODO: Have AppBar as a exported method to be used by all screens
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              emailField(customValidators().emailValidation(formPage)),
              SizedBox(height: 20.0),
              passwordField(customValidators().passwordValidation()),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  signIn(),
                  SizedBox(width: 20.0),
                  guestSignIn(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField confirmPasswordField(String password) {
    return TextFormField(
      obscureText: hideConfirmPassword,
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val, password),
      onChanged: (val) {
        setState(() => password = val);
      },
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: IconButton(
          icon: Icon(
              (hideConfirmPassword ? Icons.visibility : Icons.visibility_off),
              semanticLabel:
                  (hideConfirmPassword ? 'hide password' : 'show password')),
          onPressed: () {
            setState(() {
              hideConfirmPassword = !hideConfirmPassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  TextFormField passwordField(MultiValidator passwordValidator) {
    return TextFormField(
      obscureText: hidePassword,
      validator: passwordValidator,
      onChanged: (val) {
        setState(() => password = val);
      },
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon((hidePassword ? Icons.visibility : Icons.visibility_off),
              semanticLabel:
                  (hidePassword ? 'hide password' : 'show password')),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  TextFormField emailField(MultiValidator emailValidator) {
    return TextFormField(
      validator: emailValidator,
      keyboardType: TextInputType.emailAddress,
      onChanged: (val) {
        setState(() => email = val);
      },
      decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent[500],
      centerTitle: true,
      title: Text("Do-To-Do "),
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text(
              'Register',
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }

  RaisedButton signIn() {
    return RaisedButton(
      color: Colors.green,
      child: Text(
        'Sign-In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          dynamic result =
              await _auth.signInWithEmail(email: email, password: password);
          if (result == null) {
            print('Help');
            setState(() => error = 'Authentication Mismatch');
          }
        }
      },
    );
  }

  RaisedButton guestSignIn() {
    return RaisedButton(
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
    );
  }
}
