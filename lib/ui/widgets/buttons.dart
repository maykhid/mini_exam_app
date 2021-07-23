import 'package:flutter/material.dart';

class Button {
  static Widget rounded({
    required String buttonText,
    required var onPressed,
    isLoading = false,
    Color color = Colors.white,
    required double height,
    required double width,
  }) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  buttonText,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
