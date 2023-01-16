import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/components/alert_setting_time.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';

class TimerController extends GetxController with GetTickerProviderStateMixin {
  static TimerController get to => Get.find();

  late AnimationController animationController;

  final _time = '0:00'.obs;

  String get timeValue => _time.value;

  final _isCounting = 'start'.obs;

  String get isCountingValue => _isCounting.value;

  var _isAnimatingTimer = false.obs;

  bool get isAnimatingTimerValue => _isAnimatingTimer.value;

  final _settingMinutes = 25.obs;

  int get settingMinutesValue => _settingMinutes.value;

  List<int> get specificMinList => [5, 10, 30];

  List<String> get categoryList => ['운동', '공시'];

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this,
        duration: Duration(minutes: _settingMinutes.value),
        value: 1.0);
    _countTime();
    super.onInit();
  }

  @override
  void onReady() {
    animationController.addListener(() {
      _countTime();
      _setIsCounting();
    });
    super.onReady();
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

    _setIsCountingButtonText();
    _setIsCounting();
  }

  void _countTime() {
    Duration duration =
        (animationController.duration ?? const Duration(minutes: 25)) *
            (animationController.value);

    var hour = duration.inHours > 0 ? duration.inHours : 0;
    var dot = hour > 0 ? ':' : '';
    var min = (duration.inMinutes % 60).toString().padLeft(2, '0');
    var second = (duration.inSeconds % 60).toString().padLeft(2, '0');

    _time.value = '${hour > 0 ? hour : ''}$dot$min:$second';
  }

  void _setIsCountingButtonText() {
    _isCounting.value = animationController.isAnimating ? '정지' : '시작하기';
  }

  void _setIsCounting() {
    _isAnimatingTimer.value = animationController.isAnimating;
  }

  void addOneMinute() {
    if (_settingMinutes.value >= 180) {
      return;
    }

    _settingMinutes.value++;
  }

  void reduceOneMinute() {
    if (_settingMinutes.value < 2) {
      return;
    }

    _settingMinutes.value--;
  }

  void addSpecificMinutes(int min) {
    _settingMinutes.value += min;

    if (_settingMinutes.value > 180) {
      _settingMinutes.value -= min;
    }
  }

  void updateTimerMin() {
    animationController.duration = Duration(
        minutes: _settingMinutes.value);
    animationController.value = 1.0;
    _countTime();
  }

  void resetTimerMin() {
    _settingMinutes.value = 25;
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFFf3e5f5),
        textColor: Colors.black,
        fontSize: 16.sp);
  }
}
