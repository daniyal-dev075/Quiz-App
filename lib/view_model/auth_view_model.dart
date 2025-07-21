import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/routes/route_name.dart';
import '../utils/utils.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Utils().toastMessage('Logged In Successfully');
      Navigator.pushNamed(context, RouteName.startView);
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.message.toString());
    } finally {
      setLoading(false);
    }
  }
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Utils().toastMessage('Account Created Successfully');
      Navigator.pushNamed(context, RouteName.startView); // or wherever you want
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.message.toString());
    } finally {
      setLoading(false);
    }
  }
  void resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utils().toastMessage(
          'We have sent you an email to reset your password. Please check your inbox.');
      Navigator.pop(context); // Close bottom sheet
    } on FirebaseAuthException catch (e) {
      Utils().toastMessage(e.message.toString());
    } finally {
      setLoading(false);
    }
  }
  void logout(BuildContext context) async {
    setLoading(true);
    try {
      await _auth.signOut();
      Utils().toastMessage('Logged Out');
      Navigator.pushNamed(context, RouteName.loginView);
    } catch (e) {
      Utils().toastMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }


}

