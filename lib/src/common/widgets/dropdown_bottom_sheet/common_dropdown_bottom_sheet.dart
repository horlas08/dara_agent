import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';

class CommonDropdownBottomSheet extends StatefulWidget {
  final String title;
  final double bottomSheetHeight;
  final List<String> dropdownItems;
  final RxString selectedItem;
  final TextEditingController textController;
  final List<String>? selectedValue;
  final Function(dynamic)? onValueSelected;
  final Function? onValueUnSelected;
  final String currentlySelectedValue;
  final bool showSearch;
  final bool? isUnselectedValue;
  final String? searchHint;
  final String notFoundText;
  final bool? isShowTitle;
  final double? borderRadius;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;

  const CommonDropdownBottomSheet({
    super.key,
    required this.dropdownItems,
    required this.selectedItem,
    required this.textController,
    required this.title,
    required this.bottomSheetHeight,
    this.selectedValue,
    this.onValueSelected,
    required this.currentlySelectedValue,
    this.showSearch = false,
    this.searchHint,
    this.onValueUnSelected,
    this.isUnselectedValue = false,
    required this.notFoundText,
    this.isShowTitle = false,
    this.borderRadius,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
  });

  @override
  State<CommonDropdownBottomSheet> createState() =>
      _CommonDropdownBottomSheetState();
}

class _CommonDropdownBottomSheetState extends State<CommonDropdownBottomSheet> {
  late TextEditingController _searchController;
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.dropdownItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.dropdownItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
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
          if (widget.isShowTitle == true) ...[
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Image.asset(
                      PngAssets.closeCommonIcon,
                      width: 28,
                      color: AppColors.lightTextPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightPrimary.withValues(alpha: 0),
                    AppColors.lightPrimary,
                    AppColors.lightPrimary.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ],
          if (widget.showSearch) ...[
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              height: 54,
              child: TextField(
                controller: _searchController,
                onChanged: _filterItems,
                textAlignVertical: TextAlignVertical.center,
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
                    borderRadius: _getBorderRadius(),
                    borderSide: BorderSide(
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: _getBorderRadius(),
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
          ],
          _filteredItems.isEmpty
              ? Expanded(
                  child: _buildEmptyState(notFoundText: widget.notFoundText),
                )
              : _buildItemsList(),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 18, top: 20),
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          final isSelected = widget.currentlySelectedValue == item;

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
                  toggleWalletSelection(item, index);
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
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
                ),
              ),
            ),
          );
        },
        itemCount: _filteredItems.length,
      ),
    );
  }

  Widget _buildEmptyState({required String notFoundText}) {
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
            notFoundText,
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
    if (widget.selectedItem.value == item) {
      widget.selectedItem.value = "";
      widget.textController.clear();
      if (widget.isUnselectedValue == true) {
        widget.onValueUnSelected!();
      }
    } else {
      widget.selectedItem.value = item;
      widget.textController.text = item;
      if (widget.selectedValue != null &&
          index < widget.selectedValue!.length) {
        widget.onValueSelected?.call(widget.selectedValue![index]);
      }
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
