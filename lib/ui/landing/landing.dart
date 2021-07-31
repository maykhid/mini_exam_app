import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/strings/app_strings.dart';
import 'package:exam_cheat_detector/ui/landing/landing_view_model.dart';
import 'package:exam_cheat_detector/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(builder: (context, model, __) {
      return Scaffold(
        // image
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.jpg'),
            ),
          ),

          // intro and buttons
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 55.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Intro
                  Container(
                    height: 15.h,
                    width: 60.w,
                    // color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          AppStrings.app_name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // description
                        Text(
                          AppStrings.lorem_text,
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 1,
                            fontSize: 10.sp,
                            fontStyle: FontStyle.italic,
                          ),
                          textDirection: TextDirection.ltr,
                        )
                      ],
                    ),
                  ),

                  //Buttons
                  Container(
                    // color: Colors.red,
                    height: 25.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //
                        Button.rounded(
                            width: 45.h,
                            height: 9.h,
                            color: AppColors.brownRed,
                            buttonText: AppStrings.get_started,
                            onPressed: () {}),

                        //
                        Button.rounded(
                            width: 45.h,
                            height: 9.h,
                            color: AppColors.lightPurple,
                            buttonText: AppStrings.log_in,
                            onPressed: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
