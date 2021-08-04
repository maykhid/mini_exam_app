import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService navigationService;
  SignUpViewModel({required this.navigationService});

  // mimic signup for now
  signUp({bool success = true}) async {
    await Future.delayed(Duration(seconds: 1));

    if (!success) {
      print('Error on Login');
    } else {
      navigationService.navigateTo(Home.routeName);
    }
  }
}
