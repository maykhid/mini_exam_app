import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/core/repositories/firebase_auth_repo.dart';
import 'package:exam_cheat_detector/core/services/auth/firebase_auth_source.dart';
import 'package:exam_cheat_detector/core/use_cases/firebase_auth_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:exam_cheat_detector/core/repositories/firestore_repo.dart';
import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';
import 'package:exam_cheat_detector/core/use_cases/firebasedb_usecase.dart';
import 'package:exam_cheat_detector/ui/screens/question/question_view_model.dart';

var locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator
// navigation service
    ..registerLazySingleton<NavigationService>(() => NavigationService())
// external dependencies
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseAuth.instance)

    // data
    ..registerLazySingleton<FirestoreSource>(
        () => FirestoreSourceImpl(firebaseFirestore: locator()))
    ..registerLazySingleton<FirebaseAuthSource>(
        () => FirebaseAuthSourceImpl(firebaseAuth: locator()))

    // repo
    ..registerLazySingleton<FirestoreRepo>(
        () => FirestoreRepoImpl(firestoreSource: locator()))
    ..registerLazySingleton<FirebaseAuthRepo>(
        () => FirebaseAuthRepoImpl(firebaseAuthSource: locator()))

    // use case
    ..registerLazySingleton<FirestoreDBUseCase>(
        () => FirestoreDBUseCaseImpl(firestoreRepo: locator()))
    ..registerLazySingleton<FirebaseAuthUseCase>(
        () => FirebaseAuthUseCaseImpl(firebaseAuthRepo: locator()))

    // viewmodel
    // ..registerFactory(
    //     () => LandingViewModel(firestoreDBusecaseImpl: locator()));
    ..registerFactory(() => QuestionViewModel(firestoreDBUseCase: locator()));
}
