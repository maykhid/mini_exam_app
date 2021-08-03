import 'package:exam_cheat_detector/app/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/exam_app.dart';
import 'app/locator.dart';

// import 'app/base_view/base_view_model.dart';
/// Note to self: Desired fonts pacifico and Open sans condensed

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp()
      .whenComplete(() => print('FirebaseApp Initializing done'))
      .then((value) => print('FirebaseApp ${value.name} Initialized'))
      .onError((error, stackTrace) =>
          print('Error: $error, StackTrace: $stackTrace'));

  await setUpLocator();

  runApp(
    ExamApp(),
  );
}
