import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/ui/screens/question/question_screen.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService navigationService;
  HomeViewModel({required this.navigationService});

  /// Navigate to the [QuestionScreen] with [FirestoreParams] specifying the collection and document to access from Firestore
  void loadQuestionScreen(String collection, String document) {
    navigationService.navigateTo(QuestionScreen.routeName,
        arguments: FirestoreParams(collection: collection, document: document));
  }
}
