import 'dart:ui';

import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/ui/screens/home/home_view_model.dart';
import 'package:exam_cheat_detector/ui/widgets/header.dart';
import 'package:exam_cheat_detector/ui/widgets/picture_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

//TODO: Show a pop-up telling the user the subject he's about taking and the duration of the test and any other crucial detail before navigating to QuestionScreen
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: ChangeNotifierProvider(
        create: (_) => HomeViewModel(navigationService: locator()),
        builder: (context, _) {
          return Builder(
            builder: (context) {
              var homeViewModel = Provider.of<HomeViewModel>(context);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<String>(
                        future: homeViewModel.username(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data != null)
                            return HomeHeader(username: snapshot.data);
                          return HomeHeader(username: 'loading...');
                        }),

                    SizedBox(height: 8.h),

                    PictureContainer(),
                    //
                    // SizedBox(
                    //   height: 4.h,
                    // ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Individual subject test',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    HomeMenuButton(
                      buttonColor: AppColors.lightPurple,
                      buttonText: 'English',
                      onTap: () => homeViewModel.loadQuestionScreen(
                        'collection-QA',
                        'english',
                      ),
                    ),

                    SizedBox(height: 2.h),

                    HomeMenuButton(
                      buttonColor: AppColors.brownRed,
                      buttonText: 'Geography',
                      onTap: () => homeViewModel.loadQuestionScreen(
                        'collection-QA',
                        'geography',
                      ),
                    ),

                    SizedBox(height: 2.h),

                    HomeMenuButton(
                      buttonColor: AppColors.lightPurple,
                      buttonText: 'Biology',
                      onTap: () => homeViewModel.loadQuestionScreen(
                        'collection-QA',
                        'biology',
                      ),
                    ),

                    SizedBox(height: 2.h),

                    HomeMenuButton(
                      buttonColor: AppColors.brown,
                      buttonText: 'General Knowledge',
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeMenuButton extends StatelessWidget {
  HomeMenuButton(
      {required this.buttonColor, required this.buttonText, this.onTap});
  final String buttonText;
  final Color buttonColor;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        // color: Colors.black,
        height: 10.h,
        width: 100.w,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(10),
            left: Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.sp,
            ),
          ),
        ),
      ),
    );
  }
}
