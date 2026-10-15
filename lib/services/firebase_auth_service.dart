import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  static Future<UserModel?> login(UserModel user) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: user.email,
            password: user.password!,
          );

      UserModel? userData = await _getUserInfo(credential.user!.uid);

      return userData;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFriendlyMessage(e.code);
      throw errorMessage;
    } catch (e) {
      String errorMessage = "something went wrong try again later";
      throw errorMessage;
    }
  }

  static Future<void> register(UserModel user) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password!,
          );
      user.id = credential.user?.uid;
      await _createUser(user);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFriendlyMessage(e.code);
      throw errorMessage;
    } catch (e) {
      String errorMessage = "something went wrong try again later";
      throw errorMessage;
    }
  }

  static CollectionReference<UserModel> _getUsersCollection() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, options) => value.toJson(),
          );

  static Future _createUser(UserModel user) async {
    CollectionReference<UserModel> collection = _getUsersCollection();
    DocumentReference doc = collection.doc(user.id); //uui
    await doc.set(user);
  }

  static Future<UserModel?> _getUserInfo(String id) async {
    CollectionReference<UserModel> collection = _getUsersCollection();
    DocumentReference<UserModel> doc = collection.doc(id);
    DocumentSnapshot<UserModel> snapshot = await doc.get();
    return snapshot.data();
  }

  static String _getFriendlyMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  static Future<UserCredential?> loginWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();

        return await FirebaseAuth.instance.signInWithPopup(googleProvider);
      }

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  static Future<UserCredential?> signUpWithGoogle() async {
    try {
      if (kIsWeb) {
        return await FirebaseAuth.instance.signInWithPopup(
          GoogleAuthProvider(),
        );
      }

      final googleUser = await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException {
      rethrow;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }
}
