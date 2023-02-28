import 'package:hive/hive.dart';
import 'manager/hive_manager.dart';

part 'subcategory.g.dart';

@HiveType(typeId: HiveModelType.subcategory)
class SubCategoryModel extends HiveObject {
  static const String boxName = 'subcategory';

  @HiveField(0)
  String subcategoryName;

  @HiveField(1)
  int? accumulatedHourForAWeek = 0;

  @HiveField(2)
  int? latestTimestamp;

  SubCategoryModel(
      {required this.subcategoryName,
      this.accumulatedHourForAWeek,
      this.latestTimestamp});
}
