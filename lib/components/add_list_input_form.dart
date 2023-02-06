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
  VoidCallback? onAddEvent;

  AddListInputForm(
      {this.editingController,
      this.hintText,
      this.focusBorderColor,
      this.enableBorderColor,
      this.onChangedEvent,
      this.onTapOutside,
      this.onAddEvent,
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
                initialValue: hintText,
                controller: editingController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                onChanged: onChangedEvent,
                // onEditingComplete: onTapOutside,
                onTapOutside: (e) {
                  if (onTapOutside == null) {
                    return;
                  }

                  onTapOutside!();
                },
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
                onEvent: onAddEvent,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h)
      ],
    );
  }
}
