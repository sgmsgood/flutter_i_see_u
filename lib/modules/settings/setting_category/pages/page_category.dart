import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/model/category.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
import 'package:flutter_i_see_u/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppbar(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: const Color(0xFFF1EEF1),
                child: Column(
                  children: [
                    _buildArrangeStyle(),
                    _buildListView(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return SliverAppBar(
      backgroundColor: const Color(0xFFF1EEF1),
      expandedHeight: 172.h,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'My\nCategories',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 8.w,
            ),
            Obx(
              () => Text(
                '${controller.categoriesList.length}',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        titlePadding: EdgeInsets.only(left: 32.w, bottom: 16.h),
        background: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(60))),
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }

  Widget _buildArrangeStyle() {
    return Stack(
      children: [
        Container(
          height: 64.h,
          color: Colors.white,
        ),
        Container(
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: const BoxDecoration(
            color: Color(0xFFF1EEF1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.editCategory);
                  },
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.padded,
                    minimumSize: Size(45.w, 45.w),
                  ),
                  icon: Image.asset('assets/ic_add.png')),
              SizedBox(
                width: 8.w,
              ),
              IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.padded,
                    minimumSize: Size(45.w, 45.w),
                  ),
                  icon: Image.asset(
                      true ? 'assets/ic_list.png' : 'assets/ic_big.png')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return Obx(
      () {
        var list = controller.categoriesList.toList();

        return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70))),
            padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
            child: list.isNotEmpty
                ? _buildCategoryExist(list)
                : SizedBox(
                    height: Get.height - 64.h - 172.h - 42.h,
                    child: Image.asset('assets/img_category_empty.png')));
      },
    );
  }

  Widget _buildCategoryExist(List<CategoryModel> list) {
    return Column(
      children: list
          .map(
            (e) => InkWell(
              onTap: () {
                controller.getDataByCategoryName(e.categoryName);
                Get.toNamed(Routes.editCategory);
              },
              child: Container(
                width: double.infinity,
                height: 80.h,
                child: Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.categoryName),
                        _buildDeleteButton(e.categoryName),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDeleteButton(String categoryName) {
    return IconButton(
      onPressed: () => controller.removeCategory(categoryName),
      icon: const Icon(Icons.delete_forever),
    );
  }
}
