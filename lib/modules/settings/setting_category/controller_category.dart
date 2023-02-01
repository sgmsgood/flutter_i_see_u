import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CategoryController extends GetxController {
  final _editCurrentIndex = 0.obs;

  int get editCurrentIndexValue => _editCurrentIndex.value;

  TextEditingController? editingController;

  final categoriesList = <CategoryModel>[].obs;

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
    var categoryName = _categoryName.value;
    if(_getCategory(categoryName) != null) {
      return;
    }

    categoriesList.add(CategoryModel(categoryName: _categoryName.value));
  }

  CategoryModel? _getCategory(String categoryName) {
    return categoriesList.firstWhereOrNull((element) => element.categoryName == categoryName);
  }
}

enum CategoryArguments {
  categoryName,
}
