import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';

class CommonAuthTextInputField extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool readOnly;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final List<String>? autofillHints;
  final VoidCallback? onTap;
  final double? borderRadius;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final String? labelText;
  final bool isRequired;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final int? maxLine;

  const CommonAuthTextInputField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.readOnly = false,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.autofillHints,
    this.onTap,
    this.borderRadius,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.labelText,
    this.isRequired = false,
    this.labelStyle,
    this.floatingLabelStyle,
    this.maxLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      autofillHints: autofillHints,
      onTap: onTap,
      style:
          textStyle ??
          TextStyle(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        label: labelText != null && isRequired
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(labelText!),
                  Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              )
            : (labelText != null ? Text(labelText!) : null),
        labelStyle:
            labelStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
        floatingLabelStyle:
            floatingLabelStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
        alignLabelWithHint: maxLine != 1,
        filled: true,
        fillColor: backgroundColor ?? AppColors.white,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            TextStyle(
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
              fontSize: 15.sp,
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(color: AppColors.lightPrimary, width: 1.w),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        topLeftBorderRadius?.r ?? borderRadius?.r ?? 50.r,
      ),
      topRight: Radius.circular(
        topRightBorderRadius?.r ?? borderRadius?.r ?? 50.r,
      ),
      bottomLeft: Radius.circular(
        bottomLeftBorderRadius?.r ?? borderRadius?.r ?? 50.r,
      ),
      bottomRight: Radius.circular(
        bottomRightBorderRadius?.r ?? borderRadius?.r ?? 50.r,
      ),
    );
  }
}
