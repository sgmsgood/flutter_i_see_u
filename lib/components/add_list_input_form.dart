import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/components/button_icon_square_opacity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_field_round_border.dart';

class AddListInputForm extends StatelessWidget {
  const AddListInputForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextFieldRoundBorder(
            hintText: '추가할 하위 항목을 입력하세요.',
            // onChangedEvent: controller.setCategoryName,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          flex: 1,
          child: IconSquareOpacityButton(
            icon: Icons.add,
            backgroundColor: Colors.black.withOpacity(0.4),
            buttonSize: Size(32.w, 32.w),
            // onEvent: controller.addSubcategory,
          ),
        ),
      ],
    );
  }
}
