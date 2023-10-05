import 'package:flutter/material.dart';
import 'package:hemmah/text_style.dart';

import 'app.colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.title,
    this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.focusedBorderColor = Colors.transparent,
    this.backgroundColor = AppColors.lightGrey,
    this.minLines = 1,
    this.maxLines,
    this.contentPadding = EdgeInsetsDirectional.zero,
    this.onChange,
  }) : super(key: key);

  final String title;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color focusedBorderColor;
  final Color backgroundColor;
  final int minLines;
  final int? maxLines;
  final EdgeInsetsDirectional contentPadding;
  final Function(String value)? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text(
            title,
            style: AppTextStyle.subTitle,
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          minLines: minLines,
          maxLines: maxLines,
          cursorColor: AppColors.primary,
          cursorHeight: 20,
          textInputAction: TextInputAction.done,
          onChanged: onChange,
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyle.inputText,
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: true,
            contentPadding: contentPadding,
            hintText: title,
            hintStyle: AppTextStyle.hintText,
            hintMaxLines: 1,
            prefix: const SizedBox(width: 30),
            enabledBorder: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(color: focusedBorderColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder({
    Color color = Colors.transparent,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }
}
