import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_i_see_u/modules/timer/controller_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SetTimeComponent extends GetView<TimerController> {
  const SetTimeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('집중할 시간을 선택해주세요.', style: TextStyle(fontSize: 13.sp)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  _buildCountNumInput(),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: _buildPlusAndMinusNumButtons(),
                  ),
                ],
              ),
              SizedBox(
                width: 8.w,
              ),
              Text('min', style: TextStyle(fontSize: 12.sp))
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecificNumCard('5'),
              SizedBox(
                width: 8.w,
              ),
              _buildSpecificNumCard('10'),
              SizedBox(
                width: 8.w,
              ),
              _buildSpecificNumCard('30')
            ],
          ),
        ],
      ),
      contentPadding:
          EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 0),
      actionsPadding: EdgeInsets.only(top: 4.h),
      actions: [
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              '취소',
              style: TextStyle(fontSize: 12.sp, color: Color(0xFF7A7779),),

            )),
        TextButton(
            onPressed: () {},
            child: Text('확인',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Color(0xFF7A7779),
                )))
      ],
    );
  }

  Widget _buildCountNumInput() {
    return Container(color: Color(0xFFF1EEF1), width: 176.w, height: 80.w);
  }

  Widget _buildPlusAndMinusNumButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 24.w,
          width: 24.w,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Color(0xFFF1EEF1),
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              Icons.keyboard_arrow_up_sharp,
              color: Color(0xFF7A7779),
            ),
          ),
        ),
        SizedBox(
          height: 24.w,
          width: 24.w,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Color(0xFFF1EEF1),
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Color(0xFF7A7779),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSpecificNumCard(String min) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: Color(0xFFF1EEF1), borderRadius: BorderRadius.circular(8)),
      child: Text(
        "$min min",
        style: TextStyle(
          color: Color(0xFF7A7779),
        ),
      ),
    );
  }
}
