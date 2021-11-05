import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({required this.username});
  final String? username;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      // color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // greet and name
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                'Hello,',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.sp,
                ),
              ),

              //
              Text(
                username!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // avatar
          Container(
            height: 6.h,
            width: 13.w,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class NavHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // arrow
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            // code below makes sure theres no padding on IconButton
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),

          //
        ],
      ),
    );
  }
}
