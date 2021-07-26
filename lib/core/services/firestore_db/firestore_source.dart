import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';

abstract class FirestoreSource {
  Future<void> addDataToDB(FirestoreParams params);
  Future<DocumentSnapshot<Map<String, dynamic>>> retrieveDataFromDB(FirestoreParams params);
}

/// Class with basic firestore functions
class FirestoreSourceImpl extends BaseViewModel implements FirestoreSource {
  final FirebaseFirestore firebaseFirestore;

  FirestoreSourceImpl({required this.firebaseFirestore});

  /// Should be called when needed to add data to firestore
  /// passing the necessary params needed
  @override
  Future<void> addDataToDB(FirestoreParams params) async {
    try {
      await firebaseFirestore
          .collection(params.collection)
          .doc(params.document)
          .set(params.data);
    } on FirebaseException catch (e) {
      throw ServerError(e.code);
    }
  }

  /// Should be called when needed to get data from firestore
  /// passing the necessary params needed
  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> retrieveDataFromDB(FirestoreParams params) async {
    try {
      var data = await firebaseFirestore
          .collection(params.collection)
          .doc(params.document)
          .get();
      return data;
    } on FirebaseException catch (e) {
      throw ServerError(e.code);
    }
  }
}
