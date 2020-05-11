import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // // TODO:Sign-in Anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      print(user);
      return user;
    }
    catch (e) {
      print(e.toString());
    }
  }

  
  //TODO: Sign-in With Email-ID


//TODO: Register with Email & Password


// TODO: Sign-Out
}
