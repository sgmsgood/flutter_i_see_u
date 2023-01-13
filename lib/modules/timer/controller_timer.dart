import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/components/component_set_time.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';

class TimerController extends GetxController with GetTickerProviderStateMixin {
  static TimerController get to => Get.find();

  late AnimationController animationController;

  final _time = ''.obs;

  String get timeValue => _time.value;

  final _isCounting = 'start'.obs;

  String get isCountingValue => _isCounting.value;

  var isAnimatingTimer = false.obs;

  bool get isAnimatingTimerValue => isAnimatingTimer.value;

  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationController.addListener(() {
      countTime();
      _setIsCounting();
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void movingTimer(BuildContext context) {
    if (animationController.isAnimating) {
      animationController.stop();
    } else {
      animationController.reverse(
          from: animationController.value == 0.0
              ? 1.0
              : animationController.value);
    }

    _setIsCounting();
    _buildSetInterval(context);
  }

  void countTime() {
    Duration duration = (animationController.duration ?? Duration(seconds: 0)) *
        (animationController.value);
    _time.value =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void _setIsCounting() {
    _isCounting.value = animationController.isAnimating ? 'stop' : 'play';
  }

  void _buildSetInterval(BuildContext context) {
    // showDialog(
    //     context: context,
    //     builder: (_) => FromToTimePicker(
    //       onTab: (from, to) {
    //         print('from $from to $to');
    //       },
    //     ));
    Get.dialog(
      AlertDialog(
        title: Text('집중할 시간을 선택해주세요.', style: TextStyle(fontSize: 15.sp)),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(color: Color(0xFFF1EEF1), width: 200.w, height: 100.w),
            SizedBox(
              width: 8.w,
            ),
            Text('min', style: TextStyle(fontSize: 12.sp))
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('취소', style: TextStyle(fontSize: 12.sp))),
          TextButton(onPressed: () {}, child: Text('확인', style: TextStyle(fontSize: 12.sp)))
        ],
      ),
    );
  }
}
