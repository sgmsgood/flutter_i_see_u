
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:get/get.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}