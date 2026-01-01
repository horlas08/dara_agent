import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';

class CommonAppBar extends StatelessWidget {
  final String? title;
  final double? horizontalPadding;
  final GestureTapCallback? backLogicFunction;
  final bool? isBackLogicApply;
  final bool? showRightSideWidget;
  final Widget? rightSideWidget;
  final int? selectedIndex;

  const CommonAppBar({
    super.key,
    this.title,
    this.horizontalPadding,
    this.backLogicFunction,
    this.isBackLogicApply = false,
    this.showRightSideWidget = false,
    this.rightSideWidget,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (selectedIndex != null && isBackLogicApply == true) {
                Get.find<HomeController>().selectedIndex.value = 0;
                backLogicFunction?.call();
              } else if (selectedIndex != null) {
                Get.find<HomeController>().selectedIndex.value = 0;
                Get.back();
              } else if (isBackLogicApply == true) {
                backLogicFunction?.call();
              } else {
                Get.back();
              }
            },
            child: Image.asset(PngAssets.arrowLeftCommonIcon, width: 24),
          ),
          Spacer(),
          Transform.translate(
            offset: Offset(
              showRightSideWidget == true && rightSideWidget != null ? 0 : -10,
              0,
            ),
            child: Text(
              title ?? "",
              style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: AppColors.lightTextPrimary,
              ),
            ),
          ),
          Spacer(),
          if (showRightSideWidget == true && rightSideWidget != null)
            rightSideWidget!,
        ],
      ),
    );
  }
}
