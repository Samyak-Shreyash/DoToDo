import 'package:dotodo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  //TODO: Create Local User Object from Firebase User

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //TODO: Create Stream to listen for Authentication changes
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
//        .map((FirebaseUser user) => _userFromFirebaseUser(user));

  }

  // // TODO:Sign-in Anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      print(user);
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
    }
  }


//TODO: Sign-in With Email-ID


//TODO: Register with Email & Password


// TODO: Sign-Out
}
