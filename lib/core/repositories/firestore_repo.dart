import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/core/errors/server_error.dart';
import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';

abstract class FirestoreRepo {
  Future<void> storeData(FirestoreParams patams);
  Future<DocumentSnapshot<Map<String, dynamic>>> retreiveData(FirestoreParams params);
}

class FirestoreRepoImpl extends FirestoreRepo {
  final FirestoreSource firestoreSource;

  FirestoreRepoImpl({required this.firestoreSource});

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> retreiveData(FirestoreParams params) async {
    try {
      var data = await firestoreSource.retrieveDataFromDB(params);
      return data;
    } on ServerError catch (e) {
      throw ServerError(e.message);
    }
  }

  @override
  Future<void> storeData(FirestoreParams params) async {
    try {
      await firestoreSource.addDataToDB(params);
    } on ServerError catch (e) {
      print(e);
    }
  }
}
