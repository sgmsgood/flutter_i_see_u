import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 160.h,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'My\nCategories',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 8.w,),
                Text(
                  '${controller.categoryValue.keys.toList().length}',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            titlePadding: EdgeInsets.only(left: 32.w, bottom: 16.h),
            background: Container(

            ),
          ),
          bottom: ,
        ),
      ],
    ));
  }

//   Widget _buildListView() {
//     var list = ['1', '2', '3', '4', '5', '6', '7'];
//
//     return SizedBox(
//       height: 56.h,
//       child: ListView.separated(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemBuilder: (c, i) {
//             return Container();
//           },
//           separatorBuilder: (c, i) {
//             return SizedBox(
//               width: 16.w,
//             );
//           },
//           itemCount: list.length),
//     );
//   }
// }
}
