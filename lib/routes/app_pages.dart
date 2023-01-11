import 'package:flutter_i_see_u/modules/timer/binding_timer.dart';
import 'package:flutter_i_see_u/modules/timer/page_timer.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.timer;

  static final routes = [
    GetPage(
      name: Routes.timer,
      page: () => const TimerPage(),
      binding: TimerBinding(),
    ),
  ];
}
