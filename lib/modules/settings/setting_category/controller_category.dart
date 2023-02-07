import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:flutter_i_see_u/model/manager/hive_manager.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

class CategoryController extends GetxController {
  final _editCurrentIndex = 0.obs;

  int get editCurrentIndexValue => _editCurrentIndex.value;

  TextEditingController? categoryEditingController;

  RxList<TextEditingController> subCategoryEditingControllerList =
      <TextEditingController>[].obs;

  final categoriesList = <CategoryModel>[].obs;

  final _categoryName = ''.obs;

  String get categoryNameValue => _categoryName.value;

  final _subCategoriesList = <String>[''].obs;

  List<String> get subCategoriesListValue => _subCategoriesList;

  final categoryArgument = ''.obs;

  final _hiveManager = HiveManager();

  @override
  void onInit() {
    print("@!!----init 1");
    categoriesList.value = _hiveManager.getBoxData(CategoryModel.boxName);
    print("@!!----init 2::: ${categoriesList[1].subCategories?.length ?? 0}");

    super.onInit();
  }

  @override
  void onClose() {
    for (var element in subCategoryEditingControllerList) {
      element.dispose();
    }

    super.onClose();
  }

  void initEditingTextControllerList() {
    categoryEditingController ??= TextEditingController();

    if (subCategoryEditingControllerList.isEmpty) {
      for (var element in subCategoriesListValue) {
        subCategoryEditingControllerList
            .add(TextEditingController());
      }
    }

    _subCategoriesList.forEachIndexed((index, element) =>
        subCategoryEditingControllerList[index].text = element);
  }

  void setCurrentStepIndex(int index) => _editCurrentIndex.value = index;

  void setNextStep() {
    if (_editCurrentIndex.value > 0) {
      return;
    }

    _editCurrentIndex.value++;
  }

  void setCategoryName({String? categoryName}) {
    if (categoryName != null) {
      _categoryName.value = categoryName;
      return;
    }

    if (categoryEditingController?.text == null) {
      return;
    }

    _categoryName.value = categoryEditingController?.text ?? '';
  }

  void saveCategoryName() async {
    var categoryName = _categoryName.value;
    if (_getCategoryModel(categoryName) != null) {
      return;
    }

    categoriesList.add(CategoryModel(categoryName: _categoryName.value));

    var keyList =
        categoriesList.map((element) => element.categoryName).toList();
    await _hiveManager.saveList<CategoryModel>(
        CategoryModel.boxName, keyList, categoriesList);
  }

  void setSubCategoryList(int index, String subCategory) {
    var unregisterSubCategories =
        _subCategoriesList.where((element) => element != subCategoryEditingControllerList[index].text).toList();

    if (unregisterSubCategories.isEmpty) {
      return;
    }

    _subCategoriesList[index] = subCategoryEditingControllerList[index].text;
  }

  List<String> hasEmptySubCategory() {
    return subCategoryEditingControllerList.map((v) => v.text.isEmpty.toString()).toList();
  }

  void _removeEmptySubCategory() {
    var emptySubcategory = hasEmptySubCategory();

    if (emptySubcategory.isEmpty || _subCategoriesList.length == 1) {
      return;
    }

    _subCategoriesList.removeWhere((element) => element.isEmpty);
  }

  Future<void> saveSubCategory() async {
    var categoryModel = _getCategoryModel(_categoryName.value);
    if (categoryModel == null) {
      return;
    }

    _removeEmptySubCategory();
    print("@!!----------_subCategoriesList: $_subCategoriesList");
    categoryModel.subCategories = [..._subCategoriesList];

    await _hiveManager.save<CategoryModel>(
        CategoryModel.boxName, _categoryName.value, categoryModel);

    categoriesList.value = _hiveManager.getBoxData(CategoryModel.boxName);
    getSubCategoryByCategory();
    _showSnackBar(title: '하위 정보 저장 완료!');
  }

  void _showSnackBar({required String title, String? explain}) {
    Get.snackbar(
      title,
      explain ?? '',
      backgroundColor: const Color(0xFFE1E9FE),
    );
  }

  CategoryModel? _getCategoryModel(String categoryName) {
    return categoriesList
        .firstWhereOrNull((element) => element.categoryName == categoryName);
  }

  void getSubCategoryByCategory() {
    if (_categoryName.value.isEmpty) {
      _subCategoriesList.value = [''];
    }

    categoriesList.value = _hiveManager.getBoxData(CategoryModel.boxName);

    var categoryModel = _getCategoryModel(_categoryName.value);

    _subCategoriesList.value = (categoryModel?.subCategories?.isEmpty ?? true)
        ? ['']
        : categoryModel?.subCategories ?? [''];
  }

  void addSubcategory() {
    if (_subCategoriesList.contains('')) {
      _showSnackBar(title: '하위 카테고리 오류', explain: '빈 하위 카테고리를 입력해주세yo! 😟');
      return;
    }

    subCategoryEditingControllerList.add(TextEditingController());
    _subCategoriesList.add('');
  }
}

enum CategoryArguments {
  categoryName,
}
