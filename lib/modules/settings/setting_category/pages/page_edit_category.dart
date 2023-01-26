import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:get/get.dart';

class EditCategoryPage extends GetView<CategoryController> {
  const EditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.2,
        title: const Text('카테고리 추가'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => CupertinoStepper(
              currentStep: controller.editCurrentIndexValue,
              onStepTapped: controller.setEditCurrentIndex,
              steps: [
                Step(
                  title: Text('카테고리 추가'),
                  content: Container(
                    width: 100,
                    height: 100,
                    child: Text('zzzzzzztq'),
                  ),
                ),
                Step(
                  title: Text('종목 추가'),
                  subtitle: null,
                  content: Container(
                    width: 100,
                    height: 100,
                    child: Text('zzzzzz12314ztq'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Step _buildStep(String title, Widget contents) {
    return Step(
      title: Text('1'),
      subtitle: null,
      content: Container(
        width: 100,
        height: 100,
        child: Text('zzzzzzztq'),
      ),
    );
  }
}
