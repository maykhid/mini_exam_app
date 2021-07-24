import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../ui/widgets/header.dart';

class BaseView extends StatelessWidget {
  // final Widget body;
  final EdgeInsets? padding;
  final Widget? body;
  final bool? resizeToAvoidBottomInsets;
  final Color backgroundColor;
  // final PrefferedHeader header;

  const BaseView({
    Key? key,
    this.padding,
    this.backgroundColor = Colors.white,
    this.resizeToAvoidBottomInsets,
    this.body,
    // this.header = PrefferedHeader.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 100.w * 0.03,
                vertical: 3.h,
              ),
          //
          child: body!,
        ),
      ),
    );
  }
}

enum PrefferedHeader { home, nav, none }

getHeader(PrefferedHeader header) {
  if (header == PrefferedHeader.home) return HomeHeader();
  if (header == PrefferedHeader.nav) return NavHeader();

  return Container();
}
