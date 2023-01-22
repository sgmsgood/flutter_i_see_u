import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/components/alert_setting_time.dart';
import 'package:flutter_i_see_u/modules/timer/components/button_drop_down.dart';
import 'package:flutter_i_see_u/modules/timer/components/button_menu.dart';
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black87,
                Colors.grey,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 24.h,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCategoryRadio(),
                    SizedBox(height: 4.h),
                    DropDownButton(
                      subjectsList: const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                    ),
                    SizedBox(height: 10.h),
                    _buildTimer(),
                    SizedBox(height: 16.h),
                    _buildStartButton(context),
                  ],
                ),
              ),
              // Positioned(
              //   top: 4.h,
              //   right: 8.w,
              //   child: MenuButton(
              //     iconAsset: 'assets/ic_setting.png',
              //     buttonSize: 40.w,
              //   ),
              // ),
              Positioned(
                bottom: 10.h,
                left: 0,
                right: 0,
                child: _buildButtons(),
              ),
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
            return Obx(
              () => InkWell(
                onTap: !controller.isAnimatingTimerValue
                    ? () => controller.setSelectedCategoryIndex(index)
                    : () => controller.showToast('타이머를 멈추고 설정해주세요.🦄'),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 16.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFe3daff),
                        Color(0xFFF1EEF1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                        color: controller.selectedCategoryIndexValue == index
                            ? Color(0xFFFF8D87)
                            : Colors.transparent,
                        width: 2.w),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.categoryList[index],
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                ),
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

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MenuButton(
          onEvent: () {},
          iconAsset: 'assets/ic_graph.png',
          buttonTitle: '통계',
        ),
        MenuButton(
          onEvent: () {},
          iconAsset: 'assets/ic_award.png',
          buttonTitle: '랭킹',
        ),
        MenuButton(
          onEvent: () {},
          iconAsset: 'assets/ic_full.png',
          buttonTitle: '전체 화면',
        ),
        MenuButton(
          onEvent: () => Get.toNamed('/settings'),
          iconAsset: 'assets/ic_setting.png',
          buttonTitle: '설정',
        ),
      ],
    );
  }
}
