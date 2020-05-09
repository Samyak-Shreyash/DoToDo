import 'package:dotodo/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';

// import 'package:dotodo/screens/home/home.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  check to return Home Screens or Authentication Screens
    return Authenticate();
  }
}
