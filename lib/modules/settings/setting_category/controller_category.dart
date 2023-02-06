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

  TextEditingController? editingController;

  final categoriesList = <CategoryModel>[].obs;

  final _categoryName = ''.obs;

  String get categoryNameValue => _categoryName.value;

  final _subCategoriesList = <String>[].obs;

  List<String> get subCategoriesListValue => _subCategoriesList;

  final categoryArgument = ''.obs;

  final _hiveManager = HiveManager();

  @override
  void onInit() {
    editingController = TextEditingController();
    categoriesList.value = _hiveManager.getBoxData(CategoryModel.boxName);

    super.onInit();
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

  void setCategoryName({String? categoryName}) {
    if (categoryName != null) {
      _categoryName.value = categoryName;
      return;
    }

    if (editingController?.text == null) {
      return;
    }

    _categoryName.value = editingController?.text ?? '';
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
        _subCategoriesList.where((element) => element != subCategory).toList();

    if (unregisterSubCategories.isEmpty) {
      return;
    }

    _subCategoriesList[index] = subCategory;
  }

  void removeEmptySubCategory() {
    var emptySubcategory = _subCategoriesList.where((v) => v.isEmpty).toList();

    if (emptySubcategory.isEmpty || emptySubcategory.length == 1) {
      return;
    }

    emptySubcategory.forEachIndexed((index, element) {
      _subCategoriesList.remove('');
    });
  }

  void saveSubCategory() async {
    print("@!!--_categoryName.value: ${_categoryName.value}");
    var categoryModel = _getCategoryModel(_categoryName.value);
    print("@!!----------1");
    if (categoryModel == null) {
      print("@!!----------2");
      return;
    }

    categoryModel.subCategories?.forEach((element) {
      print("@!!------------COMPARE:: 1: $element");
    });

    _subCategoriesList.toList().forEach((e) {
      print("@!!------------COMPARE:: 2: $e");
    });

    // var isSameSubCategory = const DeepCollectionEquality()
    //     .equals(categoryModel.subCategories, _subCategoriesList);
    // print("@!!----------3");
    //
    // if (isSameSubCategory) {
    //   print("@!!----------4");
    //   return;
    // }

    removeEmptySubCategory();
    categoryModel.subCategories = _subCategoriesList;


    await _hiveManager.save<CategoryModel>(
        CategoryModel.boxName, _categoryName.value, categoryModel);

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

    _subCategoriesList.value =
        _getCategoryModel(_categoryName.value)?.subCategories ?? [''];

    print("@!!--------------------------------_subCategoriesList:: ${_subCategoriesList.length}");
  }

  void addSubcategory() {
    if (_subCategoriesList.contains('')) {
      _showSnackBar(title: '하위 카테고리 오류', explain: '빈 하위 카테고리를 입력해주세yo! 😟');
      return;
    }

    _subCategoriesList.add('');
  }
}

enum CategoryArguments {
  categoryName,
}
