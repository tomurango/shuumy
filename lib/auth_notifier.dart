import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  AuthNotifier() {
    initializeUser();
  }

  Future<void> initializeUser() async {
    _user = _auth.currentUser;
    notifyListeners();
    return;
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      _user = userCredential.user;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;  // ログアウトしたので、ユーザー情報もnullに更新します。
    notifyListeners();  // 状態が変化したのでリスナーに通知します。
  }
}
