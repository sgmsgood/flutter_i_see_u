import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownButton extends StatelessWidget {
  List<String> subjectsList;

  DropDownButton({required this.subjectsList});

  @override
  Widget build(BuildContext context) {

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: subjectsList
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: 'Brazil',
        onChanged: (value) {
          // setState(() {
          //   selectedValue = value as String;
          // });
        },
        icon: Icon(
            Icons.arrow_drop_down_sharp,
            size: 20.w
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 160,
        buttonPadding: EdgeInsets.symmetric(horizontal: 8.w),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.transparent,
          ),
          color: Colors.white.withOpacity(0.7),
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14,),
        dropdownMaxHeight: 200,
        dropdownWidth: 160,
        dropdownPadding: EdgeInsets.only(bottom: 10),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(0, -5),
      ),
    );
  }
}
