import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/app/route_generator.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';
import 'package:exam_cheat_detector/ui/screens/landing/landing.dart';
import 'package:exam_cheat_detector/ui/screens/landing/landing_view_model.dart';
import 'package:exam_cheat_detector/ui/screens/login/login.dart';
import 'package:exam_cheat_detector/ui/screens/question/question_screen.dart';
import 'package:exam_cheat_detector/ui/screens/signup/signup.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sizer/sizer.dart';

import 'base_view/base_view_model.dart';
import 'consts/app_themes.dart';

class ExamApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ExamAppState createState() => _ExamAppState();
}

class _ExamAppState extends State<ExamApp> {
  String setInitialRoute(bool value) {
    // TODO: check if user is logged in then assign route, for now use preffered bool value
    if (value) {
      return LandingScreen.routeName;
    } else {
      return Home.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
          providers: _providers,
          builder: (context, _) {
            return MaterialApp(
              theme: AppTheme.lightTheme(context),
              navigatorKey: locator<NavigationService>()
                  .navigatorKey, // navigator key from NavigationService
              initialRoute: setInitialRoute(true),
              onGenerateRoute: RouteGenerator.generateRoute,
              routes: _routes,
            );
          },
        );
      },
    );
  }
}

List<SingleChildWidget> _providers = [
  ChangeNotifierProvider(
    create: (_) => BaseViewModel(),
  ),
  ChangeNotifierProvider(
    create: (_) => LandingViewModel(navigationService: locator()),
  ),
];

//
Map<String, Widget Function(BuildContext)> _routes = {
  '/login': (context) => LoginScreen(),
  '/signUp': (context) => SignUpScreen(),
  '/questionScreen': (context) => QuestionScreen(),
};
