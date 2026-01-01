import 'package:flutter/material.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final String text;
  final VoidCallback? onPressed;
  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;

  const CommonButton({
    super.key,
    this.width = double.infinity,
    this.height = 54,
    this.borderRadius = 50.0,
    required this.text,
    this.onPressed,
    this.fontWeight = FontWeight.w900,
    this.fontSize = 17,
    this.textColor = AppColors.white,
    this.borderColor,
    this.borderWidth = 0.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor ?? AppColors.lightPrimary,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: textColor,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
