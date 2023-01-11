import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerController extends GetxController with GetTickerProviderStateMixin{
  static TimerController get to => Get.find();

  AnimationController? animationController;

  var time = ''.obs;

  String get timerString {
    Duration duration = (animationController!.duration)! * (animationController!.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }


  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this, duration: Duration(minutes: 20));
  }


}
