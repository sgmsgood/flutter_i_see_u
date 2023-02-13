import 'package:flutter/material.dart';
import 'package:flutter_i_see_u/components/button_icon_square_opacity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_field_round_border.dart';

class AddListInputForm extends StatelessWidget {
  TextEditingController? editingController;
  String? hintText;
  Color? focusBorderColor;
  Color? enableBorderColor;
  ValueChanged<String>? onChangedEvent;
  VoidCallback? onTapOutside;
  VoidCallback? onRemoveEvent;

  AddListInputForm(
      {this.editingController,
      this.hintText,
      this.focusBorderColor,
      this.enableBorderColor,
      this.onChangedEvent,
      this.onTapOutside,
      this.onRemoveEvent,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 9,
              child: TextFormField(
                autofocus: false,
                textInputAction: TextInputAction.done,
                controller: editingController,
                decoration: InputDecoration(
                    hintText: (editingController?.text.isEmpty ?? true)
                        ? '하위 카테고리를 입력해주세요.'
                        : '',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                validator: (value){},
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              flex: 1,
              child: IconSquareOpacityButton(
                icon: Icons.remove,
                backgroundColor: Colors.black.withOpacity(0.4),
                buttonSize: Size(32.w, 32.w),
                onEvent: onRemoveEvent,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h)
      ],
    );
  }
}
