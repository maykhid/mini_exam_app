import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/app/navigation_service.dart';
import 'package:exam_cheat_detector/ui/screens/home/home.dart';
import 'package:exam_cheat_detector/ui/screens/landing/landing.dart';
import 'package:exam_cheat_detector/ui/screens/landing/landing_view_model.dart';
import 'package:exam_cheat_detector/ui/screens/login/login.dart';
import 'package:exam_cheat_detector/ui/screens/question/question_screen.dart';
import 'package:exam_cheat_detector/ui/screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
          providers: _providers,
          builder: (context, _) {
            var baseView = Provider.of<BaseViewModel>(context);

            return StreamBuilder<User?>(
              stream: baseView.onAuthStateChanged, // A stream of Userr
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  print(snapshot.data);
                  return _materialApp(context, snapshot);
                }
                return Container();
              },
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
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  QuestionScreen.routeName: (context) => QuestionScreen(),
  LandingScreen.routeName: (context) => LandingScreen(),
  Home.routeName: (context) => Home(),
};

MaterialApp _materialApp(BuildContext context, AsyncSnapshot<User?> snapshot) {
  return MaterialApp(
    theme: AppTheme.lightTheme(context),
    navigatorKey: locator<NavigationService>()
        .navigatorKey, // navigator key from NavigationService
    initialRoute: snapshot.hasData ? Home.routeName : LandingScreen.routeName,

    // onGenerateRoute: RouteGenerator.generateRoute,
    routes: _routes,
  );
}
