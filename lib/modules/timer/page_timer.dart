import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:circular_countdown_timer/countdown_text_format.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/modules/timer/components/component_counter.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TimerPage extends GetView<TimerController> {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: Get.height,
          color: Colors.black45.withOpacity(0.60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDropdown(),
              SizedBox(height: 16.h),
              CounterComponent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 160.w,
          child: DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "집중할 항목을 선택하세요.",
              ),
            ),
            onChanged: print,
            selectedItem: "Brazil",
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.92),
            foregroundColor: Colors.white,
            highlightColor: Colors.transparent,
            shadowColor: Colors.white.withOpacity(0.2),
            minimumSize: Size(24.w, 24.w),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text(
                '추가',
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
