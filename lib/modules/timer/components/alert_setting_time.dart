import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_i_see_u/modules/timer/components/button_time_alert_arrow.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class SettingTimeAlert extends GetView<TimerController> {
  const SettingTimeAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text('집중할 시간을 선택해주세요. (최대 180분)', style: TextStyle(fontSize: 12.sp)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _buildCountNumInput(),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: _buildPlusAndMinusNumButtons(),
                  ),
                ],
              ),
              SizedBox(
                width: 8.w,
              ),
              Text('min', style: TextStyle(fontSize: 20.sp))
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          _buildSpecificNumberArea(),
        ],
      ),
      contentPadding:
          EdgeInsets.only(left: 18.w, right: 18.w, top: 8.h, bottom: 0),
      actionsPadding: EdgeInsets.only(top: 4.h),
      actions: _buildActionButtons(),
    );
  }

  Widget _buildCountNumInput() {
    return Container(
      color: const Color(0xFFF1EEF1),
      width: 112.w,
      height: 48.w,
      alignment: Alignment.center,
      child: Obx(
        () => Text(
          "${controller.settingMinutesValue}",
          style: TextStyle(fontSize: 30.sp, color: Color(0xFF7A7779)),
        ),
      ),
    );
  }

  Widget _buildPlusAndMinusNumButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TimeAlertArrowButton(
          buttonIcon: Icons.keyboard_arrow_up_sharp,
          onEvent: controller.addOneMinute,
        ),
        TimeAlertArrowButton(
          buttonIcon: Icons.keyboard_arrow_down_sharp,
          onEvent: controller.reduceOneMinute,
        ),
      ],
    );
  }

  Widget _buildSpecificNumberArea() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.specificMinList
            .mapIndexed(
              (i, e) => Column(
                children: [
                  _buildSpecificNumCard(e),
                  Visibility(
                    visible: i == controller.specificMinList.length - 1,
                    child: SizedBox(
                      width: 4.w,
                    ),
                  ),
                ],
              ),
            )
            .toList());
  }

  Widget _buildSpecificNumCard(int min) {
    return InkWell(
      onTap: () => controller.addSpecificMinutes(min),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
            color: const Color(0xFFF1EEF1),
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          "$min min",
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xFF7A7779),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              controller.resetTimerMin();
              controller.updateTimerMin();
            },
            child: Text(
              '초기화',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFFc2185b),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    '취소',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF7A7779),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    controller.updateTimerMin();
                    Get.back();
                  },
                  child: Text('설정',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF7A7779),
                      ))),
            ],
          ),
        ],
      )
    ];
  }
}
