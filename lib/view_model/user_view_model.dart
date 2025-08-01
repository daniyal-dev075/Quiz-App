import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../model/user_model.dart';

class UserViewModel extends ChangeNotifier {
  UserModel? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? get user => _user;

  Future<void> fetchUser() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists) {
          _user = UserModel.fromMap(doc.data()!);
          notifyListeners();
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching user data: $e');
    }
  }
}
