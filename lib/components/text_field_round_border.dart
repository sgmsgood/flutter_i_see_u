import 'package:flutter/material.dart';

class TextFieldRoundBorder extends StatelessWidget {
  String? hintText;
  Color? focusBorderColor;
  Color? enableBorderColor;
  VoidCallbackWithString? onChangedEvent;

  TextFieldRoundBorder({this.hintText, this.focusBorderColor, this.enableBorderColor, this.onChangedEvent, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: '추가할 카테고리를 입력하세요.'),
      onChanged: onChangedEvent,
    );
  }
}

typedef VoidCallbackWithString = void Function(String text);
