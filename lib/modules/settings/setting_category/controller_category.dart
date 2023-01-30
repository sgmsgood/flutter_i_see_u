import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CategoryController extends GetxController {
  final _editCurrentIndex = 0.obs;

  int get editCurrentIndexValue => _editCurrentIndex.value;

  TextEditingController? editingController;

  final categoriesMap = <String, List<String>>{}.obs;

  final _categoryName = ''.obs;

  String get categoryNameValue => _categoryName.value;

  final subCategoriesList = <String>[].obs;

  final categoryArgument = ''.obs;

  @override
  void onInit() {
    editingController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    categoryArgument.value =
        Get.arguments[CategoryArguments.categoryName.toString()] ?? '';
    super.onReady();
  }

  @override
  void onClose() {
    editingController?.dispose();
    super.onClose();
  }

  void setCurrentStepIndex(int index) => _editCurrentIndex.value = index;

  void setNextStep() {
    if (_editCurrentIndex.value > 0) {
      return;
    }

    _editCurrentIndex.value++;
  }

  void setCategoryName() {
    if (editingController?.text == null) {
      return;
    }

    _categoryName.value = editingController?.text ?? '';
  }

  void saveCategoryName() {
    categoriesMap.addAll({_categoryName.value: []});
  }
}

enum CategoryArguments {
  categoryName,
}
