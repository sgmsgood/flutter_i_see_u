import 'package:flutter/material.dart';

class TextFieldRoundBorder extends StatelessWidget {
  TextEditingController? editingController;
  String? hintText;
  Color? focusBorderColor;
  Color? enableBorderColor;
  VoidCallbackWithString? onChangedEvent;
  VoidCallback? onTapOutside;


  TextFieldRoundBorder(
      {this.editingController, this.hintText, this.focusBorderColor, this.enableBorderColor, this.onChangedEvent, this.onTapOutside, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
          enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: '추가할 카테고리를 입력하세요.'),
      onChanged: onChangedEvent,
      onEditingComplete: onTapOutside,
    );
  }
}

typedef VoidCallbackWithString = void Function(String text);
