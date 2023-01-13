import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimerPage extends GetView<TimerController> {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: 360.w,
          // color: Colors.black45.withOpacity(0.60),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black87,
              Colors.grey,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimer(),
              SizedBox(height: 16.h),
              _buildStartButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer() {
    return Container(
      width: 280.w,
      height: 280.w,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Obx(
        () => Text(
          controller.timeValue,
          style: TextStyle(color: Colors.white, fontSize: 100.sp),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () => controller.movingTimer(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          minimumSize: Size(112.w, 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // radius you want
            side: const BorderSide(
              color: Colors.transparent, //color
            ),
          ),
        ),
        child: Text(
          controller.isCountingValue,
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
      ),
    );
  }
}
