import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/locator.dart';
import 'package:exam_cheat_detector/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:exam_cheat_detector/app/base_view/base_view.dart';

import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<LandingViewModel>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(
        navigationService: locator(),
      ),
      child: Builder(
        // stream: null,
        builder: (context) {
          var loginModel = Provider.of<LoginViewModel>(context);
          // var signUpModel = Provider.of<LoginViewModel>(context);

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
                      CustomTextField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: loginModel.emailController,
                      ),

                      // password Textfield
                      CustomTextField(
                        obscureText: true,
                        hintText: 'Password',
                        controller: loginModel.passwordController,
                      ),

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
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.lightPurple),
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(25.w, 5.h)),
                        ),
                        onPressed: () => loginModel.validateInput(context),
                        child: Text('Login'),
                      ),

                      // new user? sign up
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
