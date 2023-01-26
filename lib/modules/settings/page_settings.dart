import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/pages/page_category.dart';
import 'package:flutter_i_see_u/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: _buildButton(onEvent: () => Get.toNamed(Routes.settingCategory), buttonText: '1234'),
        ),
      ),
    );
  }

  Widget _buildButton({required VoidCallback onEvent, required String buttonText,}) {
    return ElevatedButton(onPressed: onEvent, child: Text(buttonText));
  }
}
