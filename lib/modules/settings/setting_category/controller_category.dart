import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:flutter_i_see_u/model/manager/hive_manager.dart';
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

  final _hiveManager = HiveManager();

  @override
  void onInit() {
    editingController = TextEditingController();
    categoriesList.value = _hiveManager.getBoxData(CategoryModel.boxName);
    print("@!!--categoriesList: ${categoriesList.length}");
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

  void saveCategoryName() async {
    var categoryName = _categoryName.value;
    if(_getCategory(categoryName) != null) {
      return;
    }

    categoriesList.add(CategoryModel(categoryName: _categoryName.value));

    var keyList = categoriesList.map((element) => element.categoryName).toList();
    await _hiveManager.saveList<CategoryModel>(CategoryModel.boxName, keyList, categoriesList);
  }

  CategoryModel? _getCategory(String categoryName) {
    return categoriesList.firstWhereOrNull((element) => element.categoryName == categoryName);
  }
}

enum CategoryArguments {
  categoryName,
}
