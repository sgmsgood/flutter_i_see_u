import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CategoryController extends GetxController {
  final RxMap<String, List<String>> _categoryMap = <String, List<String>>{}.obs;

  Map<String, List<String>> get categoryValue => _categoryMap;

  final _categoryTitles = ['수능', '공무원 시험', '공인중개사', '토익', '한국사'].obs;

  List<String> get categoryTitlesValue => _categoryTitles;

  final _editCurrentIndex = 0.obs;

  int get editCurrentIndexValue => _editCurrentIndex.value;

  void addCategory(String category) {
    _categoryMap.addAll({category: []});
  }

  void setEditCurrentIndex(int index) {
    _editCurrentIndex.value = index;
  }

  void setNextStep() {
    _editCurrentIndex.value++;
  }

  @override
  String toString() {
    return 'CategoryController{_categoryMap: $_categoryMap}';
  }
}
