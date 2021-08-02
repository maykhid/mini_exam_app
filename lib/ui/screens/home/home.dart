import 'dart:ui';

import 'package:exam_cheat_detector/app/base_view/base_view.dart';
import 'package:exam_cheat_detector/ui/widgets/header.dart';
import 'package:exam_cheat_detector/ui/widgets/picture_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Column(
        children: [
          HomeHeader(),

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

          Container(
            color: Colors.black,
            height: 10.h,
          ),
          SizedBox(height: 2.h),
          Container(
            color: Colors.red,
            height: 10.h,
          ),
          SizedBox(height: 2.h),
          Container(
            color: Colors.blue,
            height: 10.h,
          ),
          SizedBox(height: 2.h),
          Container(
            color: Colors.blueGrey,
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
