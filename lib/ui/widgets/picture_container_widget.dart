import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:exam_cheat_detector/app/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PictureContainer extends StatelessWidget {
  const PictureContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      width: 100.w,
      decoration: BoxDecoration(
        // color: Colors.black,
        // borderRadius: BorderRadius.all(BorderRadius.)
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        border: Border.all(color: Colors.blueGrey),
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/home_image.jpg'),
        ),
      ),

      // details
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 6.w),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              width: 50.w,
              height: 20.h,

              // picture container details
              child: Column(
                children: [
                  //
                  Text(
                    'Want to take a full test?',
                    style: TextStyle(
                        fontSize: 23.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  //
                  SizedBox(
                    height: 3.h,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.get_started,
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size.fromWidth(20.w)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.brown)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
