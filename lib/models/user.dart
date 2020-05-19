import 'package:dotodo/services/auth.dart';

class User {

  final AuthService _auth = AuthService();
  final String uid;

  User({this.uid});

}
