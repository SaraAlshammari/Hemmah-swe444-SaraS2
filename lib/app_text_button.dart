import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.primary,
    this.borderColor = Colors.transparent,
    this.radius = 10,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final void Function() onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color borderColor;
  final double radius;
  final int fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsetsDirectional.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor,
          ),
          elevation: 4,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: fontSize.floorToDouble(),
            fontWeight: fontWeight,
            color: const Color(0xFF616161),
          ),
        ),
      ),
    );
  }
}
