import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:get/get.dart';

class TimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TimerController());
  }
}