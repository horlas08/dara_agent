import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';

class CommonCountryDropdownBottomSheet extends StatefulWidget {
  final String title;
  final double bottomSheetHeight;
  final List<String> dropdownItems;
  final RxString selectedItem;
  final TextEditingController textController;
  final List<String>? countryImage;
  final List<String>? countryCode;
  final List<String>? countryDialCode;
  final dynamic controller;
  final VoidCallback? clearFunction;

  const CommonCountryDropdownBottomSheet({
    super.key,
    required this.dropdownItems,
    required this.selectedItem,
    required this.textController,
    required this.title,
    required this.bottomSheetHeight,
    this.countryImage,
    this.countryCode,
    this.controller,
    this.countryDialCode,
    this.clearFunction,
  });

  @override
  State<CommonCountryDropdownBottomSheet> createState() =>
      _CommonCountryDropdownBottomSheetState();
}

class _CommonCountryDropdownBottomSheetState
    extends State<CommonCountryDropdownBottomSheet> {
  late TextEditingController _searchController;
  late List<MapEntry<int, String>> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.dropdownItems.asMap().entries.toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.dropdownItems
          .asMap()
          .entries
          .where(
            (entry) => entry.value.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      height: widget.bottomSheetHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 12),
          Container(
            width: 45,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, right: 18, top: 20),
            height: 54,
            child: TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: AppLocalizations.of(
                  context,
                )!.countryDropdownSearchHint,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.lightTextPrimary,
                  letterSpacing: 0,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 16),
                  child: Image.asset(
                    PngAssets.searchCommonIcon,
                    color: AppColors.lightTextPrimary,
                    width: 18,
                  ),
                ),
                filled: true,
                fillColor: AppColors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: AppColors.lightPrimary,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15.8,
                ),
              ),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.lightTextPrimary,
                letterSpacing: 0,
              ),
            ),
          ),
          _filteredItems.isEmpty ? _buildEmptyState() : _buildItemsList(),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 18, top: 20),
        itemBuilder: (context, index) {
          final entry = _filteredItems[index];
          final item = entry.value;
          final originalIndex = entry.key;
          final isSelected = widget.selectedItem.value == item;
          final flag =
              widget.countryImage != null &&
                  originalIndex < widget.countryImage!.length
              ? widget.countryImage![originalIndex]
              : null;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.lightPrimary.withValues(alpha: 0.10)
                  : AppColors.transparent,
            ),
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                splashColor: AppColors.lightPrimary.withValues(alpha: 0.1),
                highlightColor: AppColors.transparent,
                onTap: () {
                  toggleWalletSelection(item, originalIndex);
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      if (flag != null) ...[
                        Image.network(
                          flag,
                          width: 24,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                      ],
                      Text(
                        item,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 16,
                          color: isSelected
                              ? AppColors.lightPrimary
                              : AppColors.lightTextTertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: _filteredItems.length,
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 50,
            color: AppColors.lightTextTertiary,
          ),
          SizedBox(height: 2),
          Text(
            AppLocalizations.of(context)!.countryDropdownNotFound,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.lightTextPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }

  void toggleWalletSelection(String item, int index) {
    widget.selectedItem.value = item;
    widget.textController.text = item;

    if (widget.controller != null &&
        widget.countryCode != null &&
        index < widget.countryCode!.length &&
        widget.countryDialCode != null &&
        index < widget.countryDialCode!.length) {
      widget.controller.countryCode.value = widget.countryCode![index];
      widget.controller.countryDialCode.value = widget.countryDialCode![index];
    }

    if (widget.clearFunction != null) {
      widget.clearFunction!();
    }
  }
}
