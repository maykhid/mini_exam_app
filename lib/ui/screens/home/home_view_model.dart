import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/core/data_models/user_model.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';
import 'package:exam_cheat_detector/ui/screens/question/question_screen.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService navigationService;
  HomeViewModel({required this.navigationService});

  /// Navigate to the [QuestionScreen] with [FirestoreParams] specifying the collection and document to access from Firestore
  void loadQuestionScreen(String collection, String document) {
    navigationService.navigateTo(QuestionScreen.routeName,
        arguments: FirestoreParams(collection: collection, document: document));
  }

  Future<String> username() async {
    var user = await firebaseAuthUseCase.userInfo();
    try {
      var data = await firestoreDBUseCase.retreiveData(
          FirestoreParams(collection: 'Users', document: user!.uid));
      var name = UserModel.fromMap(data.data());
      return '${name.firstname} ${name.lastname[0].toUpperCase()}.';
    } on ServerError catch (e) {
      throw ServerError(e.message);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
