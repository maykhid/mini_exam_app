import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:exam_cheat_detector/app/base_view/base_view.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 60.h,
            width: 100.w,
            // color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Welcome back text
                Text(
                  'Welcome\n Back',
                  style: GoogleFonts.pacifico(
                    fontSize: 25.sp,
                    color: AppColors.lightPurple,
                  ),
                ),

                // enmail text field
                CustomTextField(),

                // password Textfield
                CustomTextField(),

                // forget password text
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                  ),
                ),

                // login button
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.lightPurple),
                    fixedSize: MaterialStateProperty.all<Size>(Size(25.w, 5.h)),
                  ),
                  onPressed: () {},
                  child: Text('Login'),
                ),

                // new user? sign up
              ],
            ),
          ),
        ],
      ),
    );
  }
}
