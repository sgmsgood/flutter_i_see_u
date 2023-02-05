import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:flutter_i_see_u/model/manager/hive_manager.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';
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

    print("@!!--init:: ${categoriesList.length}");
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
      print("@!!------------1");
      return;
    }

    print("@!!_---------------------2");

      _subCategoriesList[index] = subCategory;
    for (var element in unregisterSubCategories) {
      print("@!!_---------------------3: ${subCategory}");
    }
      print("@!!_---------------------4: ${_subCategoriesList[index]}");
  }

  void saveSubCategory() async {
    var categoryName = Get.arguments['categoryName'];
    var categoryModel = categoriesList.firstWhereOrNull(
        (element) => element.categoryName == categoryName);

    if (categoryModel == null) {
      log("@!!----categooryModel is Null");
      log("@!!----categoryListLength: ${categoriesList.length} / ${_categoryName.value}");
      return;
    }

    log("@!!---categoryModel:: ${categoryModel.categoryName} / ${categoryModel.subCategories?.length}");

    var isSameSubCategory = const DeepCollectionEquality().equals(categoryModel.subCategories, _subCategoriesList);

    if(isSameSubCategory) {
      print("@!!----------------------?");
      return;
    }

    categoryModel.subCategories = _subCategoriesList;

    print("@!!--categoryModel.subCategories: ${categoryModel.subCategories?.length} / categoryName: ${categoryName}");

    await _hiveManager.save<CategoryModel>(
        CategoryModel.boxName, categoryName, categoryModel);

    print("@!!--categoryModel.subCategories222: ${categoryModel.subCategories?.length}");
  }

  CategoryModel? _getCategoryModel(String categoryName) {
    return categoriesList.value
        .firstWhereOrNull((element) => element.categoryName == categoryName);
  }

  List<String> getSubCategoryByCategory(String categoryName) {
    log("@!!---111: ${_getCategoryModel(categoryName)?.subCategories}");
    return _subCategoriesList.value =
        _getCategoryModel(categoryName)?.subCategories ?? [''];
  }

  void addSubcategory() {
    _subCategoriesList.add('');
  }
}

enum CategoryArguments {
  categoryName,
}
