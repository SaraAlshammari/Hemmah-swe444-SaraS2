import 'package:flutter/material.dart';
import 'package:hemmah/text_style.dart';

import 'app.colors.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  const CustomDropdownButton({
    Key? key,
    required this.title,
    required this.hint,
    this.background = AppColors.lightGrey,
    required this.items,
    this.valueTitle,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String hint;
  final Color background;
  final List<DropdownMenuItem<T>>? items;
  final T? valueTitle;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15),
          child: Text(
            title,
            style: AppTextStyle.subTitle,
          ),
        ),
        const SizedBox(height: 15),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.only(start: 30, end: 26),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: background,
              ),
              child: DropdownButton<T>(
                hint: Text(
                  hint,
                  style: AppTextStyle.hintText,
                ),
                isExpanded: true,
                underline: const SizedBox(),
                onChanged: onChanged,
                dropdownColor: AppColors.white,
                elevation: 1,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.black,
                  size: 40,
                ),
                value: valueTitle,
                items: items,
              ),
            ),
            IgnorePointer(
              child: Container(
                margin: const EdgeInsetsDirectional.only(end: 50),
                width: 50,
                height: 40,
                color: AppColors.lightGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
