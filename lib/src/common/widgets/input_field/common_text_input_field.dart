import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';

class CommonTextInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool enabled;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final int? maxLine;
  final double? borderRadius;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final Widget? prefixIcon;
  final double? verticalPadding;
  final bool? showBorder;
  final bool isRequired;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;

  const CommonTextInputField({
    super.key,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.readOnly = false,
    this.enabled = true,
    this.textStyle,
    this.hintStyle,
    this.suffixIcon,
    this.onTap,
    this.backgroundColor,
    this.maxLine = 1,
    this.borderRadius,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.prefixIcon,
    this.verticalPadding,
    this.showBorder = true,
    this.labelText,
    this.isRequired = false,
    this.labelStyle,
    this.floatingLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      enabled: enabled,
      style:
          textStyle ??
          TextStyle(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
      maxLines: maxLine,
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
              fontSize: 16,
              letterSpacing: 0,
            ),
        enabledBorder: showBorder == true
            ? OutlineInputBorder(
                borderRadius: _getBorderRadius(),
                borderSide: BorderSide(
                  color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                  width: 1,
                ),
              )
            : OutlineInputBorder(
                borderRadius: _getBorderRadius(),
                borderSide: BorderSide.none,
              ),
        focusedBorder: showBorder == true
            ? OutlineInputBorder(
                borderRadius: _getBorderRadius(),
                borderSide: BorderSide(color: AppColors.lightPrimary, width: 1),
              )
            : OutlineInputBorder(
                borderRadius: _getBorderRadius(),
                borderSide: BorderSide.none,
              ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(topLeftBorderRadius ?? borderRadius ?? 50),
      topRight: Radius.circular(topRightBorderRadius ?? borderRadius ?? 50),
      bottomLeft: Radius.circular(bottomLeftBorderRadius ?? borderRadius ?? 50),
      bottomRight: Radius.circular(
        bottomRightBorderRadius ?? borderRadius ?? 50,
      ),
    );
  }
}
