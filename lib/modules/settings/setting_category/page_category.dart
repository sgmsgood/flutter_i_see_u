import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/settings/setting_category/controller_category.dart';
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
            Text(
              '${controller.categoryValue.keys.toList().length}',
              style: TextStyle(color: Colors.grey),
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
                    Get.bottomSheet(
                      Container(
                        padding: EdgeInsets.only(top: 16.h),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        child: Column(
                          children: [
                            Text(
                              '카테고리 추가하기',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              width: Get.width,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.categoryTitlesValue.length + 1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 3 / 1,
                                    //item 의 가로 1, 세로 2 의 비율
                                    mainAxisSpacing: 4.w,
                                    //수평 Padding
                                    crossAxisSpacing: 4.h, //수직 Padding
                                  ),
                                  itemBuilder: (c, i) {
                                    if (i ==
                                        controller.categoryTitlesValue.length) {
                                      return _buildAddCategoryButton();
                                    }
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ),
                                      child: Text(
                                        controller.categoryTitlesValue[i],
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    );
                                  }),
                            ),
                            const Spacer(),
                            const Divider(
                              thickness: 1.2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 8.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'Close',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
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
    return Obx(() {
      var list = true
          ? controller.categoryValue.keys.toList()
          : ['1', '2', '3', '4', '5', '6', '7'];

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
    });
  }

  Widget _buildCategoryExist(List<dynamic> list) {
    return Column(
      children: list
          .map(
            (e) => Container(
              width: double.infinity,
              height: 80.h,
              child: Card(
                child: Text(e),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildAddCategoryButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.add_circle_outline_rounded,
          color: Colors.deepPurpleAccent,
          size: 32.w,
        ),
      ),
    );
  }
}
