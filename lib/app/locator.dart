import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_cheat_detector/app/base_view/base_view_model.dart';
import 'package:exam_cheat_detector/core/services/firestore_db/firestore_source.dart';
import 'package:exam_cheat_detector/core/use_cases/firebasedb_usecase.dart';
import 'package:exam_cheat_detector/ui/landing/landing_view_model.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator

// external dependencies
    ..registerLazySingleton(() => FirebaseFirestore.instance)

    // data
    ..registerLazySingleton(
        () => FirestoreSourceImpl(firebaseFirestore: locator()))

    // use case
    ..registerLazySingleton(
        () => FirebaseDBUseCaseImpl(firestoreSourceImpl: locator()))

    // viewmodel
    ..registerFactory(
        () => LandingViewModel(firestoreDBusecaseImpl: locator()));
}
