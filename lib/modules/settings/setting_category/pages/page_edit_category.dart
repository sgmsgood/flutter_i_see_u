import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/components/button_icon_square_opacity.dart';
import 'package:flutter_i_see_u/components/text_field_round_border.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/add_list_input_form.dart';

class EditCategoryPage extends GetView<CategoryController> {
  EditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryName = Get.arguments['categoryName'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.2,
        title: Text(categoryName == '' ? '카테고리 추가' : "$categoryName 수정"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => EnhanceStepper(
              physics: const BouncingScrollPhysics(),
              currentStep: controller.editCurrentIndexValue,
              onStepTapped: controller.setCurrentStepIndex,
              controlsBuilder: (c, d) => const SizedBox(),
              stepIconSize: 40.w,
              steps: [
                _buildStep(
                  title: '카테고리 추가',
                  subtitle: '(필수)',
                  content: Container(
                    width: 300.w,
                    alignment: Alignment.topLeft,
                    child: _buildAddCategory(),
                  ),
                ),
                _buildStep(
                  title: '종목 추가',
                  subtitle: '(선택)',
                  content: Container(
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    child: _buildAddSubCategory(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddCategory() {
    return Column(
      children: [
        TextFieldRoundBorder(
          editingController: controller.editingController,
          hintText: '추가할 카테고리를 입력하세요.',
          onTapOutside: controller.setCategoryName,
          // onChangedEvent: controller.setCategoryName,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: controller.setNextStep,
              child: const Text('다음'),
            ),
            TextButton(
              onPressed: () {
                controller.saveCategoryName();
                controller.setNextStep();
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddSubCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddListInputForm(),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: const Text('저장'),
        ),
      ],
    );
  }

  EnhanceStep _buildStep(
      {required String title, required Widget content, String? subtitle}) {
    return EnhanceStep(
        icon: Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              color: Colors.lightGreen,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit)),
        title: Text(title),
        subtitle: Text(
          subtitle ?? '',
          style: TextStyle(fontSize: 10.sp),
        ),
        content: content,
        state: StepState.editing);
  }
}
