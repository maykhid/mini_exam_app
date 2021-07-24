import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';

abstract class FirestoreDBUseCase {
  Future<void> storeData();
  Future<void> retreiveData();
}

class FirebaseDBUseCaseImpl extends FirestoreDBUseCase {
  final FirestoreSourceImpl firestoreSourceImpl;

  FirebaseDBUseCaseImpl({required this.firestoreSourceImpl});

  @override
  Future<void> retreiveData({String? document, String? collection}) async {
    try {
      await firestoreSourceImpl.retrieveDataFromDB(
        document: document,
        collection: collection,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> storeData({String? document, String? collection, data}) async {
    try {
      await firestoreSourceImpl.addDataToDB(
        document: document,
        collection: collection,
        data: data,
      );
    } catch (e) {
      print(e);
    }
  }
}
