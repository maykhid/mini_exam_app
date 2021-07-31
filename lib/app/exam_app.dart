import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/ui/question/question_screen.dart';
import 'package:exam_cheat_detector/ui/question/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'base_view/base_view_model.dart';

class ExamApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ExamAppState createState() => _ExamAppState();
}

class _ExamAppState extends State<ExamApp> {
// TODO: 1) create setInitialRoute() with MainScreen and AuthHolders. The screen would be decided on Authentication state

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => BaseViewModel(),
              ),
              ChangeNotifierProvider(
                create: (_) => QuestionViewModel(firestoreDBUseCase: locator()),
              ),
            ],
            builder: (context, snapshot) {
              return MaterialApp(
                home: QuestionScreen(
                  collection: 'newcollection',
                  doc: 'newdoc',
                ),
              );
            });
      },
    );
  }
}
