import 'package:hive/hive.dart';
import 'manager/hive_manager.dart';

part 'category.g.dart';

@HiveType(typeId: HiveModelType.category)
class CategoryModel extends HiveObject {
  static const String boxName = 'category';

  @HiveField(0)
  String categoryName;

  @HiveField(1)
  List<String>? subCategories;

  CategoryModel({required this.categoryName, this.subCategories});
}