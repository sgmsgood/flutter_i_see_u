import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/components/button_icon_square_opacity.dart';
import 'package:flutter_i_see_u/components/text_field_round_border.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditCategoryPage extends GetView<CategoryController> {
  EditCategoryPage({super.key});

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
              stepIconSize: 40.w,
              steps: [
                _buildStep(
                  // title: '카테고리 추가',
                  title: controller.categoryNameValue,
                  subtitle: '(필수)',
                  content: Container(
                    width: 300.w,
                    // height: 50.h,
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
          hintText: '추가할 카테고리를 입력하세요.',
          onChangedEvent: controller.setCategoryName,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: controller.setNextStep,
              child: const Text('다음'),
            ),
            TextButton(
              onPressed: () => controller.addCategory(),
              child: const Text('저장'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddSubCategory() {
    print("@!!---controller.subcategasdafs::::::::::::::::oriesValue: ${controller.subcategoriesValue?.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: (controller.subcategoriesValue?.isNotEmpty ?? false)
                ? controller.subcategoriesValue
                        ?.map(
                          (e) => Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: TextFieldRoundBorder(
                                  hintText: '추가할 카테고리를 입력하세요.',
                                  onChangedEvent: controller.setCategoryName,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                flex: 1,
                                child: IconSquareOpacityButton(
                                    icon: Icons.add,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.4),
                                    buttonSize: Size(32.w, 32.w),
                                    onEvent: controller.addSubcategory),
                              ),
                            ],
                          ),
                        )
                        .toList() ??
                    []
                : [
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: TextFieldRoundBorder(
                            hintText: '추가할 카테고리를 입력하세요.',
                            onChangedEvent: controller.setCategoryName,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: IconSquareOpacityButton(
                              icon: Icons.add,
                              backgroundColor: Colors.black.withOpacity(0.4),
                              buttonSize: Size(32.w, 32.w),
                              onEvent: controller.addSubcategory),
                        ),
                      ],
                    ),
                  ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('저장'),
            ),
          ],
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
