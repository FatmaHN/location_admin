import 'package:admin_location/model/admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ServAdmin {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Admin _userFirebaseAdmin(User? firebaseUser) {
    return Admin(uid: firebaseUser!.uid);
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future registerUser(String email, String password) async {
    try {
      UserCredential endUserCredentiels = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = endUserCredentiels.user!;
      return _userFirebaseAdmin(firebaseUser);
    } catch (e) {
      print("Account creation failed , reason : " + e.toString());
      return null;
    }
  }

  Future loginUser(String login, String password) async {
    try {
      UserCredential endUserCredentials = await _firebaseAuth
          .signInWithEmailAndPassword(email: login, password: password);
      User firebaseUser = endUserCredentials.user!;
      return _userFirebaseAdmin(firebaseUser);
    } catch (e) {
      print("Account login failed, reason: " + e.toString());
      return null;
    }
  }

  Future createAdminDocument(String uid, Admin muser) async {
    try {
      await _firebaseFirestore.collection('Admin').doc(uid).set(muser.toJson());
    } catch (e) {
      print(e);
    }
  }
}
