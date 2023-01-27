import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IconSquareOpacityButton extends StatelessWidget {
  IconData? icon;
  Color? iconColor;
  Color? backgroundColor;
  VoidCallback? onEvent;
  Size? buttonSize;

  IconSquareOpacityButton({this.icon, this.buttonSize, this.backgroundColor, this.onEvent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onEvent ?? () => Get.back(),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: buttonSize ?? Size(45.w, 45.w),
          maximumSize: buttonSize ?? Size(45.w, 45.w),
          backgroundColor: backgroundColor ?? Colors.white.withOpacity(0.6),
          shadowColor: Colors.transparent),
      child: Icon(
        icon ?? Icons.arrow_back,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}
