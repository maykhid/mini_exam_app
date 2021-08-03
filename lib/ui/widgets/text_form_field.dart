import 'package:exam_cheat_detector/app/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hintText, this.obscureText = false});
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13.sp,
        fontWeight: FontWeight.w800,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: AppColors.brown.withOpacity(0.4),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
