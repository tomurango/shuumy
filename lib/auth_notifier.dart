import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  AuthNotifier() {
    initializeUser();
  }

  Future<void> initializeUser() async {
    _user = _auth.currentUser;

    if (_user == null) {
      UserCredential userCredential = await _auth.signInAnonymously();
      _user = userCredential.user;
    }

    notifyListeners();
  }
}
