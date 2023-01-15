import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimeAlertArrowButton extends StatelessWidget {
  VoidCallback onEvent;
  IconData buttonIcon;

  TimeAlertArrowButton({required this.onEvent, required this.buttonIcon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24.w,
      width: 24.w,
      child: ElevatedButton(
        onPressed: onEvent,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xFFF1EEF1),
          padding: EdgeInsets.zero,
        ),
        child: Icon(
          buttonIcon,
          color: Color(0xFF7A7779),
        ),
      ),
    );
  }
}
