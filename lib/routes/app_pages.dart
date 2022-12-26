import 'package:flutter_i_see_u/modules/page_home.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      // binding: HomeBinding(),
    ),
  ];
}
