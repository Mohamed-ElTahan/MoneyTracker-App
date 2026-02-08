import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_tracker_app/feature/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(
            UserModel(
              email: email,
              password: password,
              name: name,
              fev: [],
            ).toJson(),
          );
    } catch (e) {
      // Rethrow to allow cubit to handle the error
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Rethrow to allow cubit to handle the error
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Rethrow to allow cubit to handle the error
      rethrow;
    }
  }
}
