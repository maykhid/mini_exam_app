import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/core/entities/firestore_params.dart';
import 'package:exam_cheat_detector/core/repositories/firestore_repo.dart';

abstract class FirestoreDBUseCase {
  Future<void> storeData(FirestoreParams params);
  Future<DocumentSnapshot<Map<String, dynamic>>> retreiveData(
      FirestoreParams params);
}

class FirestoreDBUseCaseImpl extends FirestoreDBUseCase {
  final FirestoreRepo firestoreRepo;

  FirestoreDBUseCaseImpl({required this.firestoreRepo});

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> retreiveData(
          FirestoreParams params) =>
      firestoreRepo.retreiveData(params);

  @override
  Future<void> storeData(params) => firestoreRepo.storeData(params);
}
