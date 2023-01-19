import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuButton extends StatelessWidget {
  double? buttonSize;
  String iconAsset;
  String buttonTitle;

  MenuButton(
      {required this.iconAsset,
      required this.buttonTitle,
      this.buttonSize,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonSize ?? 48.w,
      height: buttonSize ?? 56.w,
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              iconAsset,
              color: Colors.white,
              width: 48.w,
              height: 48.w,
            ),
          ),
          Text(buttonTitle, style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
