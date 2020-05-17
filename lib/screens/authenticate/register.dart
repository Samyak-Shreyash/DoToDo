import 'package:dotodo/services/ValidationRules.dart';
import 'package:dotodo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //TODO: Set state variables
  String formPage = 'Register';
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.cyan[200],
      appBar: buildAppBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Card(
              elevation: 8.0,
              child: buildBox(),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            createTextField("Name", TextInputType.text,
                customValidators().textValidation(formPage)),
            SizedBox(height: 20.0),
            createTextField('Email ID', TextInputType.emailAddress,
                customValidators().emailValidation(formPage)),
            SizedBox(height: 20.0),
            passwordField(customValidators().passwordValidation()),
            SizedBox(height: 20.0),
            confirmPasswordField(password),
            SizedBox(height: 20.0),
            register(),
          ],
        ),
      ),
      decoration: BoxDecoration(),
    );
  }

  TextFormField createTextField(String label, TextInputType type,
      MultiValidator validatorType) {
    return TextFormField(
      validator: validatorType,
      keyboardType: type,
      onChanged: (val) {
        setState(() => email = val);
      },
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0))),
    );
  }

  TextFormField confirmPasswordField(String password) {
    return TextFormField(
      obscureText: hideConfirmPassword,
      validator: (val) =>
          MatchValidator(errorText: 'passwords do not match').validateMatch(
              val, password),
      onChanged: (val) {
        setState(() => password = val);
      },
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        suffixIcon: IconButton(icon: Icon(
            (hideConfirmPassword ? Icons.visibility : Icons.visibility_off),
            semanticLabel:
            (hideConfirmPassword ? 'hide password' : 'show password')),
          onPressed: () {
            setState(() {
              hideConfirmPassword = !hideConfirmPassword;
            });
          },
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
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
          icon: Icon(
              (hidePassword ? Icons.visibility : Icons.visibility_off),
              semanticLabel:
              (hidePassword ? 'hide password' : 'show password')
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  RaisedButton register() {
    return RaisedButton(
      color: Colors.green,
      child: Text(
        'Register',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          dynamic result = await _auth.registerWithEmail(
              email: email, password: password);
          if (result == null) {
            setState(() => error = 'Something happened');
          }
        }
      },
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
            label: Text('Sign-In',
              style: TextStyle(color: Colors.black),
            )
        )
      ],
    );
  }

}
