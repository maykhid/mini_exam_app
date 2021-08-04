import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService navigationService;
  LoginViewModel({required this.navigationService});

  // mimic login for now
  login({bool success = true}) async {
    await Future.delayed(Duration(seconds: 1));

    if (!success) {
      print('Error on Login');
    } else {
      navigationService.navigateTo(Home.routeName);
    }
  }
}
