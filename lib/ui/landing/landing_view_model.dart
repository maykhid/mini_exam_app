import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';
import 'package:exam_cheat_detector/core/use_cases/firebasedb_usecase.dart';

class LandingViewModel extends BaseViewModel {
  final FirebaseDBUseCaseImpl firestoreDBusecaseImpl;
  LandingViewModel({required this.firestoreDBusecaseImpl});

  Future<void> storeQA(String collection, String document, dynamic data) async {
    try {
      await firestoreDBusecaseImpl.storeData(
          document: document, collection: collection, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
