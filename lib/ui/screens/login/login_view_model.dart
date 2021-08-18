import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/helpers/validators/string_validator.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/core/entities/auth_credentials.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';
import 'package:exam_cheat_detector/ui/widgets/show_flush_bar.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService navigationService;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginViewModel({
    required this.navigationService,
  });

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
    }
    _login(context);
  }

  void _login(BuildContext context) async {
    changeState(ViewState.Busy);

    var credentials = AuthCredentials(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    var result = await firebaseAuthUseCase.login(credentials);
    changeState(ViewState.Idle);
    result.fold((failure) {
      //error
      showFlushBar(context, title: "Log-in Error", message: failure.message);
    }, (success) {
      //success
      if (success)
        navigationService.navigateToAndPopPrevious(Home.routeName);
      else
        showFlushBar(context,
            title: "Log-in Error", message: "Something went wrong");
    });
  }
}
