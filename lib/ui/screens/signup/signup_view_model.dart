import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/helpers/validators/string_validator.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/core/entities/auth_credentials.dart';
import 'package:exam_cheat_detector/core/use_cases/firebase_auth_usecase.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';
import 'package:exam_cheat_detector/ui/widgets/show_flush_bar.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService navigationService;
  final FirebaseAuthUseCase firebaseAuthUseCase;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  SignUpViewModel(
      {required this.navigationService, required this.firebaseAuthUseCase});

  // mimic signup for now
  signUp({bool success = true}) async {
    await Future.delayed(Duration(seconds: 1));

    if (!success) {
      print('Error on Login');
    } else {
      navigationService.navigateTo(Home.routeName);
    }
  }

  void _message(BuildContext context, String text) {
    showFlushBar(context, title: "Validation Error", message: text);
  }

  void validateInput(BuildContext context) {
    if (!isTextEmail(emailController.text.trim())) {
      _message(context, "Please provide a valid email");
      return;
    } else if (passwordController.text.trim().isEmpty) {
      _message(context, "Password is empty");
      return;
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      _message(context, "Password do not match");
      return;
    } else if (!isTextNumeric(firstnameController.text.trim())) {
      _message(context, "Fullname can't contain only numbers");
      return;
    } else if (!isTextNumeric(surnameController.text.trim())) {
      _message(context, "Surname can't contain only numbers");
      return;
    }
    _signUp(context);
  }

  void _signUp(BuildContext context) async {
    changeState(ViewState.Busy);
    var credentials = AuthCredentials(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstname: firstnameController.text.trim(),
        surname: surnameController.text.trim());

    var result = await firebaseAuthUseCase.createUser(credentials);
    changeState(ViewState.Idle);
    result.fold((failure) {
      //error
      showFlushBar(context, title: "SignUp Error", message: failure.message);
    }, (success) {
      //success
      if (success)
        Navigator.pushNamed(context, Home.routeName);
      else
        showFlushBar(context,
            title: "SignUp Error", message: "something went wrong");
    });
  }
}
