import 'package:exam_cheat_detector/core/use_cases/firebase_auth_usecase.dart';
import 'package:flutter/material.dart';

class BaseViewModel with ChangeNotifier {
  final FirebaseAuthUseCase? firebaseAuthUseCase;

  ViewState _state = ViewState.Idle;

  BaseViewModel({this.firebaseAuthUseCase});

  Future<bool> isLoggedIn() async =>
      await firebaseAuthUseCase!.isUserAuthenticated();

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
