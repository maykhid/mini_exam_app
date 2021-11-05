import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showFlushBar(
  BuildContext context, {
  required String title,
  required String message,
  Color backgroundColor = Colors.red,
}) {
  Flushbar(
    title: title,
    message: message,
    backgroundColor: backgroundColor,
    routeBlur: 1.5,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(5),
  ).show(context);
}
