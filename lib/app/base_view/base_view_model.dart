import 'package:exam_cheat_detector/core/use_cases/firebase_auth_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../locator.dart';

class BaseViewModel with ChangeNotifier {
  final FirebaseAuthUseCaseImpl firebaseAuthUseCase =
      FirebaseAuthUseCaseImpl(firebaseAuthRepo: locator());

  ViewState _state = ViewState.Idle;

  // BaseViewModel({required this.firebaseAuthUseCase});

  // Future<bool> isLoggedIn() async {
  //   print('BVM is: ${firebaseAuthUseCase.isUserAuthenticated()}');
  //   return await firebaseAuthUseCase.isUserAuthenticated();
  // }

  Stream<User?>? get onAuthStateChanged =>
      firebaseAuthUseCase.onAuthStateChanged;

  ViewState get state => _state;

  void changeState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  bool isBusy() => (_state == ViewState.Busy);
}

enum ViewState {
  Idle,
  Busy,
}
