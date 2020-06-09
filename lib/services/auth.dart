import 'package:dotodo/models/user.dart';
import 'package:dotodo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'globals';

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
      await DatabaseService(uid: user.uid)
          .updateUserData('SampleTask', 'low', 'shopping');
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
    }
  }


//TODO: Sign-in With Email-ID
  Future signInWithEmail({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//TODO: Register with Email & Password
  Future registerWithEmail({String email, String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('SampleTask', 'low', 'shopping');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// TODO: Sign-Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

//  //Send User UID to TaskDetails page
//  Future<String> getUserId() async
//  {
//    final FirebaseUser user = await _auth.currentUser();
//     Glo userId=  _userFromFirebaseUser(user).uid;
//
//
//
//  }


}
