import 'package:flutter/foundation.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:hive_flutter/adapters.dart';

class HiveManager {
  static const String TAG = 'HiveManager';

  static Future<void> init() async {
    await Hive.initFlutter();
    await _registerAdapters();
    await _openAllBox();
  }

  static Future<void> _registerAdapters() async {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  static Future<void> _openAllBox<T extends HiveObject>() async {
    await Hive.openBox<CategoryModel>(CategoryModel.boxName);
  }

  static Future<void> closeAll() async {
    await Hive.close();
  }

  Box<T> getBox<T extends HiveObject>(String boxName) {
    return Hive.box(boxName);
  }

  Future<void> save<T extends HiveObject>(
      String boxName, String key, T data) async {
    await Hive.box<T>(boxName).put(key, data);
  }

  Future<void> saveList<T extends HiveObject>(
      String boxName, List<String> keyList, List<T> dataList) async {
    var box = Hive.box<T>(boxName);

    for (var i = 0; i < keyList.length; i++) {
      await box.put(keyList[i], dataList[i]);
    }
  }

  Future<void> remove<T extends HiveObject>(String boxName, String key) async {
    await Hive.box<T>(boxName).delete(key);
  }

  Future<void> update<T extends HiveObject>(
      String boxName, String key, T data) async {
    await Hive.box<T>(boxName).put(key, data);
  }

  static Future<void> clearFromDisk<T extends HiveObject>() async {
    await Hive.deleteBoxFromDisk(CategoryModel.boxName);

    await Hive.close();
    await _openAllBox();
  }

  bool isBoxEmpty<T extends HiveObject>(String boxName) {
    return Hive.box<T>(boxName).isEmpty;
  }

  bool isContainsKey<T extends HiveObject>(String boxName, String key) {
    return Hive.box<T>(boxName).containsKey(key);
  }

  List<T> getBoxData<T extends HiveObject>(String boxName) {
    var loadData = Hive.box<T>(boxName).values.toList();
    return loadData;
  }
}

class HiveModelType {
  static const int category = 1;
  static const int subcategory = 2;
}
