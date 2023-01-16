import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/components/alert_setting_time.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              _buildCategoryRadio(),
              SizedBox(height: 16.h),
              _buildDropdown(),
              SizedBox(height: 16.h),
              _buildTimer(),
              SizedBox(height: 16.h),
              _buildStartButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRadio() {
    return SizedBox(
      height: 10.h,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 16.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFe3daff),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                controller.categoryList[index],
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 8.w,
            );
          },
          itemCount: controller.categoryList.length),
    );
  }

  Widget _buildDropdown() {
    var places = ['a', 'b', 'c', 'd', 'e'];

    return  DropdownButton<String>(
      selectedItemBuilder: (_) {
        return places
            .map((e) => Container(
          alignment: Alignment.center,
          child: Text(
            e,
            style: TextStyle(color: Colors.white),
          ),
        ))
            .toList();
      },
      icon: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_drop_down),
      ),
      items: places.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(
            value,
            style: TextStyle(color: Colors.black54),
          ),
        );
      }).toList(),
      onChanged: (_) {
      },
    );
  }

  Widget _buildTimer() {
    return Obx(
      () => InkWell(
        onTap: !controller.isAnimatingTimerValue
            ? () =>
                Get.dialog(barrierDismissible: false, const SettingTimeAlert())
            : () => controller.showToast('타이머를 멈추고 설정해주세요.🦄'),
        child: Container(
          width: 280.w,
          height: 280.w,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            controller.timeValue,
            style: TextStyle(color: Colors.white, fontSize: 80.sp),
          ),
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
