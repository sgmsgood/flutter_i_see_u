import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:flutter_i_see_u/model/manager/hive_manager.dart';
import 'package:flutter_i_see_u/model/subcategory.dart';
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

  final _subCategoriesList = <SubCategoryModel>[].obs;

  List<SubCategoryModel> get subCategoriesListValue => _subCategoriesList;

  final categoryArgument = ''.obs;

  final _hiveManager = HiveManager();

  final _isShowButton = false.obs;

  bool get isShowButton => _isShowButton.value;

  late CategoryModel _specificCategoryName;

  CategoryModel get specificCategoryName => _specificCategoryName;

  @override
  void onInit() {
    getCategoryListFromHive();
    super.onInit();
  }

  @override
  void onClose() {
    categoryEditingController?.dispose();
    for (var element in subCategoryEditingControllerList) {
      element.dispose();
    }
    subCategoryEditingControllerList.clear();

    super.onClose();
  }

  getCategoryListFromHive() {
    List<CategoryModel> categoryListData = _hiveManager.getBoxData<CategoryModel>(CategoryModel.boxName).toList();
    categoriesList.value = categoryListData.toList();
  }

  void setCategoryName({String? name}) {
    if (name == null) {
      return;
    }

    _categoryName.value = name;
  }

  getDataByCategoryName(String categoryName) {
    _specificCategoryName = categoriesList.firstWhere((element) => element.categoryName == categoryName);
    update();
  }


  void addSubcategory() {
    _subCategoriesList.add(SubCategoryModel(subcategoryName: ''));
  }

  void setCurrentStepIndex(int index) => _editCurrentIndex.value = index;

  void saveCategoryName() {
    var categoryName = categoryEditingController?.text ?? '';

    if (categoryName.isEmpty) {
      return;
    }

    _hiveManager.saveWithKey<CategoryModel>(CategoryModel.boxName, categoryName,
        CategoryModel(categoryName: categoryName));
  }

  void saveSubCategory(String subCategoryName) {
    if (subCategoryName.isEmpty) {
      return;
    }

    _hiveManager.saveAutoKey<SubCategoryModel>(SubCategoryModel.boxName, SubCategoryModel(subcategoryName: subCategoryName, latestTimestamp: DateTime.now().millisecond));
  }

  void removeCategory(String categoryName) {
    _hiveManager.remove<CategoryModel>(CategoryModel.boxName, categoryName);
    getCategoryListFromHive();
  }
}

enum CategoryArguments {
  categoryName,
}
