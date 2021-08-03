import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/ui/screens/login/login.dart';
import 'package:exam_cheat_detector/ui/screens/signup/signup.dart';

class LandingViewModel extends BaseViewModel {
  // final FirebaseDBUseCaseImpl firestoreDBusecaseImpl;
  // LandingViewModel({required this.firestoreDBusecaseImpl});

  // Future<void> storeQA(String collection, String document, dynamic data) async {
  //   try {
  //     await firestoreDBusecaseImpl.storeData(
  //         document: document, collection: collection, data: data);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  final NavigationService navigationService;
  LandingViewModel({required this.navigationService});

  /// Dummy login logic
  login({bool success = true}) async {
    // await Future.delayed(Duration(seconds: 1));

    if (!success) {
      print('Error on Login');
    } else {
      navigationService.navigateTo(LoginScreen.routeName);
    }
  }

  signup({bool success = true}) async {
    // await Future.delayed(Duration(seconds: 1));

    if (!success) {
      print('Error on sign up');
    } else {
      navigationService.navigateTo(SignUpScreen.routeName);
    }
  }
}
