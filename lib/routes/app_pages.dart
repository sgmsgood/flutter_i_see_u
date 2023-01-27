import 'package:flutter_i_see_u/modules/settings/binding_settings.dart';
import 'package:flutter_i_see_u/modules/settings/page_settings.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/binding_category.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/pages/page_category.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/pages/page_edit_category.dart';
import 'package:flutter_i_see_u/modules/timer/binding_timer.dart';
import 'package:flutter_i_see_u/modules/timer/components/alert_setting_time.dart';
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
    GetPage(
      name: Routes.settingTimeAlert,
      page: () => const SettingTimeAlert(),
      binding: TimerBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.settingCategory,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.editCategory,
      page: () => EditCategoryPage(),
      binding: CategoryBinding(),
    ),
  ];
}
