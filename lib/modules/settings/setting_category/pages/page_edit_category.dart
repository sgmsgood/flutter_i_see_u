import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            () => EnhanceStepper(
              physics: const BouncingScrollPhysics(),
              currentStep: controller.editCurrentIndexValue,
              onStepTapped: controller.setEditCurrentIndex,
              controlsBuilder: (c, d) => const SizedBox(),
              steps: [
                _buildStep(
                  title: '카테고리 추가',
                  subtitle: '(필수)',
                  content: Container(
                    width: 300.w,
                    // height: 50.h,
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: '추가할 카테고리를 입력하세요.'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: controller.setNextStep,
                              child: const Text('다음'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('완료'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                _buildStep(
                  title: '종목 추가',
                  subtitle: '(선택)',
                  content: Container(
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    height: 1000.h,
                    color: Colors.yellow,
                    child: Column(
                      children: [
                        Text('zzzzzz12314ztq'),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  EnhanceStep _buildStep(
      {required String title, required Widget content, String? subtitle}) {
    return EnhanceStep(
        icon: Container(color: Colors.lightGreen, child: Icon(Icons.add)),
        title: Text(title),
        subtitle: Text(
          subtitle ?? '',
          style: TextStyle(fontSize: 10.sp),
        ),
        content: content,
        state: StepState.editing);
  }
}
