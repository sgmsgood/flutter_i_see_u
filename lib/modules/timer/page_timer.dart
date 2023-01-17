import 'package:dropdown_button2/dropdown_button2.dart';
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
          padding: EdgeInsets.only(top: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryRadio(),
              SizedBox(height: 4.h),
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
    var places = ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'];

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: places
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: 'Brazil',
        onChanged: (value) {
          // setState(() {
          //   selectedValue = value as String;
          // });
        },
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          size: 20.w
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 160,
        buttonPadding: EdgeInsets.symmetric(horizontal: 8.w),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.transparent,
          ),
          color: Colors.white.withOpacity(0.7),
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14,),
        dropdownMaxHeight: 200,
        dropdownWidth: 160,
        dropdownPadding: EdgeInsets.only(bottom: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, -5),
      ),
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
