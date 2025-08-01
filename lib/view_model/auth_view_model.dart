import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    required String name,
    required String email,
    required String password,
    required BuildContext context,
    File? profileImage,
  }) async {
    setLoading(true);
    try {
      // Create user with email & password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String imageUrl = '';
      if (profileImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_profile_pics')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(profileImage);
        imageUrl = await storageRef.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,
        'profilePic': imageUrl,
      });

      Utils().toastMessage('Account Created Successfully');
      Navigator.pushNamed(context, RouteName.startView);
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

