import 'package:exam_cheat_detector/core/entities/auth_credentials.dart';
import 'package:exam_cheat_detector/core/errors/firebase_error_codes.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// enum UserStatus {
//   authenticated,
//   unauthenticated,
//   uninitialized,
// }

abstract class FirebaseAuthSource {
  // Future<bool> isUserAuthenticated();
  Future<UserCredential> createUser(AuthCredentials credentials);
  Future<UserCredential> signIn(AuthCredentials credentials);
  Stream<User?>? get onAuthStateChanged;
}

class FirebaseAuthSourceImpl with ChangeNotifier implements FirebaseAuthSource {
  final FirebaseAuth firebaseAuth;
  // late final User _user;
  // UserStatus _userStatus = UserStatus.uninitialized;

  // UserStatus get userStatus => _userStatus;

  FirebaseAuthSourceImpl({required this.firebaseAuth});

  // FirebaseAuthSourceImpl({required this.firebaseAuth}) {
  //   firebaseAuth.authStateChanges().listen(onAuthStateChanged);
  //   print('FirebaaseAuth source ran ${_userStatus.toString()}');
  // }

  // updateStatus(UserStatus status) {
  //   _userStatus = status;
  //   print(
  //       'This is the status #on updateStatus Auth -> ${_userStatus.toString()}');
  //   notifyListeners();
  // }

  @override
  Future<UserCredential> createUser(AuthCredentials credentials) async {
    try {
      return await firebaseAuth.createUserWithEmailAndPassword(
          email: credentials.email, password: credentials.password);
    } on FirebaseAuthException catch (error) {
      print(error);

      String message = "an error occurred";

      if (error.code == WEAK_PASSWORD)
        message = "the password you provided is too weak";
      else if (error.code == EMAIL_IN_USE)
        message = "this email is already taken";

      throw ServerError(message);
    }
  }

  // @override
  // Future<bool> isUserAuthenticated() async {
  //   return firebaseAuth.currentUser != null;
  // }

  Stream<User?>? get onAuthStateChanged => firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> signIn(AuthCredentials credentials) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: credentials.email, password: credentials.password);
    } on FirebaseAuthException catch (error) {
      String message = "server error";

      if (error.code == USER_NOT_FOUND)
        message = "Sorry this account doesn't exist, try signing up instead";
      else if (error.code == WRONG_PASSWORD)
        message = "please provide the correct password for this account";

      throw ServerError(message);
    }
  }

  // Future<void> onAuthStateChanged(User? user) async {
  //   if (user == null) {
  //     updateStatus(UserStatus.unauthenticated);
  //   } else {
  //     _user = user;
  //     updateStatus(UserStatus.authenticated);
  //   }
  // }
}
