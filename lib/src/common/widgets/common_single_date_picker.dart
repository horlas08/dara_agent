import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';

class CommonSingleDatePicker extends StatefulWidget {
  final String? hintText;
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final Color? fillColor;
  final double? verticalPadding;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;
  final double? borderRadius;

  const CommonSingleDatePicker({
    super.key,
    this.hintText,
    required this.onDateSelected,
    this.initialDate,
    this.suffixIcon,
    this.suffixIconColor,
    this.fillColor,
    this.verticalPadding,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
    this.borderRadius,
  });

  @override
  State<CommonSingleDatePicker> createState() => _CommonSingleDatePickerState();
}

class _CommonSingleDatePickerState extends State<CommonSingleDatePicker> {
  late DateTime _selectedDay;
  late TextEditingController _dateController;

  final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate ?? DateTime.now();
    _dateController = TextEditingController(
      text: widget.initialDate != null
          ? dateFormat.format(widget.initialDate!)
          : '',
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: AppColors.lightTextPrimary,
        letterSpacing: 0,
      ),
      controller: _dateController,
      onTap: () {
        _selectDate(context, _selectedDay, _dateController);
      },
      readOnly: true,
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? AppColors.white,
        filled: true,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15.8,
        ),
        hintStyle: TextStyle(
          color: AppColors.lightTextTertiary,
          fontWeight: FontWeight.w700,
          fontSize: 16,
          letterSpacing: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _getBorderRadius(),
          borderSide: BorderSide(color: AppColors.lightPrimary, width: 1),
        ),
        suffixIcon: widget.suffixIcon != null
            ? Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Image.asset(
                  widget.suffixIcon!,
                  width: 18,
                  height: 18,
                  color: widget.suffixIconColor,
                ),
              )
            : null,
      ),
      keyboardType: TextInputType.datetime,
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    DateTime selectedDate,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.utc(1990, 1, 1),
      lastDate: DateTime.utc(2030, 12, 31),
      borderRadius: 16,

      height: MediaQuery.of(context).size.height * 0.35,
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: AppColors.lightPrimary),
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleYearButton: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
        textStyleDayButton: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
        textStyleButtonPositive: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        textStyleButtonNegative: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        backgroundHeader: AppColors.lightPrimary,
        textStyleCurrentDayOnCalendar: TextStyle(
          letterSpacing: 0,
          color: AppColors.lightPrimary,
        ),
        textStyleDayOnCalendarSelected: TextStyle(
          letterSpacing: 0,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        _selectedDay = picked;
        widget.onDateSelected(picked);
        controller.text = dateFormat.format(picked);
      });
    }
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        widget.topLeftBorderRadius ?? widget.borderRadius ?? 50,
      ),
      topRight: Radius.circular(
        widget.topRightBorderRadius ?? widget.borderRadius ?? 50,
      ),
      bottomLeft: Radius.circular(
        widget.bottomLeftBorderRadius ?? widget.borderRadius ?? 50,
      ),
      bottomRight: Radius.circular(
        widget.bottomRightBorderRadius ?? widget.borderRadius ?? 50,
      ),
    );
  }
}
