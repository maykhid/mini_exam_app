import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';

abstract class FirestoreSource {
  Future<void> addDataToDB({String collection, String document, dynamic data});
  Future<void> retrieveDataFromDB({String collection, String document});
}

/// Class with basic firestore functions
class FirestoreSourceImpl extends BaseViewModel implements FirestoreSource {
  final FirebaseFirestore firebaseFirestore;

  FirestoreSourceImpl({required this.firebaseFirestore});

  /// Should be called when needed to add data to firestore
  /// passing the necessary params needed
  @override
  Future<void> addDataToDB({String? collection, String? document, data}) async {
    try {
      await firebaseFirestore.collection(collection!).doc(document!).set(data);
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  /// Should be called when needed to get data from firestore
  /// passing the necessary params needed
  @override
  Future<DocumentSnapshot<Map<dynamic, dynamic>>> retrieveDataFromDB(
      {String? collection, String? document}) async {
    try {
      var data =
          await firebaseFirestore.collection(collection!).doc(document).get();
      return data;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }
}
