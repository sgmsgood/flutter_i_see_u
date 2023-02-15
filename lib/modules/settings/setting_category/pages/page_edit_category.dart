import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_i_see_u/components/text_field_round_border.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/pages/page_category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/add_list_input_form.dart';

class EditCategoryPage extends GetView<CategoryController> {
  EditCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.2,
        title: Text(controller.categoryNameValue == ''
            ? '카테고리 추가'
            : "${controller.categoryNameValue} 수정"),
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
                    child: _buildAddCategory(controller.categoryNameValue),
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

  Widget _buildAddCategory(String categoryName) {
    return Column(
      children: [
        TextFieldRoundBorder(
          editingController: controller.categoryEditingController,
          hintText: categoryName == '' ? '추가할 카테고리를 입력하세요.' : categoryName,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                controller.saveCategoryName();
                controller.getCategoryListFromHive();
              },
              child: Text(categoryName == '' ? '저장' : '수정'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAddSubCategory() {
    print(
        "@!!---->>>controller.subCategoriesListValue: ${controller.subCategoriesListValue.length} vs ${controller.subCategoryEditingControllerList.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => Form(
            child: AddListInputForm(
              // editingController:
              //     controller.subCategoryEditingControllerList[i],
              hintText: 'gg',
              onRemoveEvent: () {},
              onChangedEvent: (v) {},
            ),
          ),
          itemCount: controller.subCategoriesListValue.length + 1,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('추가'),
            ),
            TextButton(
              onPressed: () async {},
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
