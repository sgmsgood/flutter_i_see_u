import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CategoryController extends GetxController {
 final RxMap<String, List<String>> _categoryMap = <String, List<String>>{}.obs;

 Map<String, List<String>> get categoryValue => _categoryMap;

 void addCategory(String category) {
  _categoryMap.addAll({category: []});
  print("@!!---------------------");
 }

 @override
  String toString() {
    return 'CategoryController{_categoryMap: $_categoryMap}';
  }
}