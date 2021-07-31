import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/core/repositories/firestore_repo.dart';
import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';
import 'package:exam_cheat_detector/core/use_cases/firebasedb_usecase.dart';
import 'package:exam_cheat_detector/ui/question/question_view_model.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator

// external dependencies
    ..registerLazySingleton(() => FirebaseFirestore.instance)

    // data
    ..registerLazySingleton<FirestoreSource>(
        () => FirestoreSourceImpl(firebaseFirestore: locator()))

    // repo
    ..registerLazySingleton<FirestoreRepo>(
        () => FirestoreRepoImpl(firestoreSource: locator()))

    // use case
    ..registerLazySingleton<FirestoreDBUseCase>(
        () => FirestoreDBUseCaseImpl(firestoreRepo: locator()))

    // viewmodel
    // ..registerFactory(
    //     () => LandingViewModel(firestoreDBusecaseImpl: locator()));
    ..registerFactory(() => QuestionViewModel(firestoreDBUseCase: locator()));
}
