import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'signup_view_model.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signUp';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(navigationService: locator()),
      child: Builder(builder: (context) {
        // Builder widget is used in this case so that we can get a context that is directly below ChangeNotifierProvider

        var signUpModel = Provider.of<SignUpViewModel>(context);

        return BaseView(
          body: SingleChildScrollView(
            child: Container(
              height: 90.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hello...!',
                          style: GoogleFonts.pacifico(
                            fontSize: 25.sp,
                            color: AppColors.lightPurple,
                          ),
                        ),

                        // name
                        CustomTextField(
                          hintText: 'First name',
                        ),

                        // surname
                        CustomTextField(
                          hintText: 'Surname',
                        ),

                        // email
                        CustomTextField(
                          hintText: 'Email',
                        ),

                        // password
                        CustomTextField(
                          obscureText: true,
                          hintText: 'Password',
                        ),

                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.lightPurple),
                            fixedSize: MaterialStateProperty.all<Size>(
                                Size(25.w, 5.h)),
                          ),
                          onPressed: () async => signUpModel.signUp(),
                          child: Text('Sign up'),
                        ),

                        SizedBox(height: 10.h),

                        Center(
                            child: Text(
                          'New User',
                          style: TextStyle(fontSize: 12.sp),
                        )),

                        // Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
