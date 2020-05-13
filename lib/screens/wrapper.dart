import 'package:dotodo/models/user.dart';
import 'package:dotodo/screens/authenticate/authenticate.dart';
import 'package:dotodo/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//    print(user);
    // TODO: check to return Home Screens or Authentication Screens

    return user != null ? Home() : Authenticate();
  } 
}
