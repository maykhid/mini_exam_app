import 'package:exam_cheat_detector/app/locator.dart';
// import 'package:exam_cheat_detector/ui/landing/landing.dart';
// import 'package:exam_cheat_detector/ui/question/question_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/exam_app.dart';
import 'app/locator.dart';

// import 'app/base_view/base_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await setUpLocator();

  runApp(
    ExamApp(),
  );
}
