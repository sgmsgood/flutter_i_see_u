import 'package:hive/hive.dart';
import 'manager/hive_manager.dart';

part 'subcategory.g.dart';

@HiveType(typeId: HiveModelType.subcategory)
class SubCategoryModel extends HiveObject {
  static const String boxName = 'subcategory';

  @HiveField(0)
  int? index;

  @HiveField(1)
  String? subcategoryName;

  @HiveField(2)
  int? accumulatedHourForAWeek = 0;

  @HiveField(3)
  int? latestTimestamp;

  SubCategoryModel(
      {this.index,
      this.subcategoryName,
      this.accumulatedHourForAWeek,
      this.latestTimestamp});
}
