import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/ui/home/home.dart';
// import 'package:exam_cheat_detector/ui/landing/landing.dart';
// import 'package:exam_cheat_detector/ui/question/question_screen.dart';
import 'package:exam_cheat_detector/ui/question/question_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// import 'app/base_view/base_view_model.dart';

void main() {
  runApp(
    ExamApp(),
  );
}

class ExamApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
          providers: [
            // ChangeNotifierProvider(
            //   create: (_) => BaseViewModel(),
            // ),
            ChangeNotifierProvider(
              create: (_) => QuestionViewModel(),
            ),
          ],
          builder: (context, snapshot) {
            return MaterialApp(
                home: BaseView(
              body: Home(),
              // header: PrefferedHeader.home,
            ));
          });
    });
  }
}
