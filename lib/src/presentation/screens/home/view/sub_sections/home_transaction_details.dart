import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/model/dashboard_model.dart';

class HomeTransactionDetails extends StatefulWidget {
  final Transactions transaction;

  const HomeTransactionDetails({super.key, required this.transaction});

  @override
  State<HomeTransactionDetails> createState() => _HomeTransactionDetailsState();
}

class _HomeTransactionDetailsState extends State<HomeTransactionDetails> {
  Color _getStatusColor(String? status) {
    switch (status) {
      case "Success":
        return AppColors.success;
      case "Pending":
        return AppColors.warning;
      default:
        return AppColors.error;
    }
  }

  Color _getAmountColor(bool? isPlus) {
    return isPlus == true ? AppColors.success : AppColors.error;
  }

  String _getAmountPrefix(bool? isPlus) {
    return isPlus == true ? "+" : "-";
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final localization = AppLocalizations.of(context)!;

    final calculateDecimals = DynamicDecimalsHelper().getDynamicDecimals(
      currencyCode: transaction.trxCurrencyCode!,
      siteCurrencyCode: Get.find<SettingsService>().getSetting(
        "site_currency",
      )!,
      siteCurrencyDecimals: Get.find<SettingsService>().getSetting(
        "site_currency_decimals",
      )!,
      isCrypto: transaction.isCrypto!,
    );

    return AnimatedContainer(
      width: double.infinity,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTransactionInfo(calculateDecimals),
                    SizedBox(height: 30.h),
                    _buildDescription(),
                    SizedBox(height: 30.h),
                    _buildDetailRow(
                      label: localization.homeTransactionDetailsWallet,
                      value: Text(
                        "${transaction.walletType} (${transaction.trxCurrencyCode})",
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 15.sp,
                          color: AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    _buildAmountRow(
                      localization.homeTransactionDetailsCharge,
                      transaction.charge ?? "",
                      transaction.charge,
                      transaction.isPlus,
                      transaction.isCrypto,
                      transaction.trxCurrencyCode,
                      transaction.trxCurrencySymbol,
                      calculateDecimals,
                    ),
                    _buildDetailRow(
                      label: localization.homeTransactionDetailsTransactionId,
                      value: Text(
                        transaction.tnx ?? "",
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 15.sp,
                          color: AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    _buildDetailRow(
                      label: localization.homeTransactionDetailsMethod,
                      value: Text(
                        transaction.method ?? "",
                        style: TextStyle(
                          letterSpacing: 0,
                          fontSize: 15.sp,
                          color: AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    _buildAmountRow(
                      localization.homeTransactionDetailsTotalAmount,
                      transaction.finalAmount ?? "",
                      transaction.finalAmount,
                      transaction.isPlus,
                      transaction.isCrypto,
                      transaction.trxCurrencyCode,
                      transaction.trxCurrencySymbol,
                      calculateDecimals,
                    ),
                    _buildDetailRow(
                      label: localization.homeTransactionDetailsStatus,
                      value: _buildStatusChip(transaction.status),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    String amount,
    String? charge,
    bool? isPlus,
    bool? isCrypto,
    String? currencyCode,
    String? currencySymbol,
    int? calculateDecimals,
  ) {
    final isCharge = label.toLowerCase().contains("charge");
    final color = isCharge ? AppColors.error : _getAmountColor(isPlus);

    return _buildDetailRow(
      label: label,
      value: Text(
        "${double.tryParse(amount.toString())?.toStringAsFixed(calculateDecimals!)} $currencyCode",
        textAlign: TextAlign.right,
        overflow: TextOverflow.visible,
        softWrap: true,
        style: TextStyle(
          letterSpacing: 0,
          fontWeight: FontWeight.w900,
          fontSize: 15.sp,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, required Widget value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              letterSpacing: 0,
              fontSize: 15.sp,
              color: AppColors.lightTextTertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(child: value),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String? status) {
    final statusColor = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
        color: statusColor.withValues(alpha: 0.05),
      ),
      child: Text(
        status ?? "",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
          fontSize: 12.sp,
          color: statusColor,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 2.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.lightPrimary.withValues(alpha: 0),
            AppColors.lightPrimary,
            AppColors.lightPrimary.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        SizedBox(height: 12.h),
        Container(
          width: 50.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: AppColors.lightTextPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          localization.homeTransactionDetailsTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
            color: AppColors.lightTextPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDivider(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildTransactionInfo(int calculateDecimals) {
    final transaction = widget.transaction;
    final dateParts = transaction.createdAt?.split(",") ?? [];
    final date = dateParts.isNotEmpty ? dateParts.first : "";
    final time = dateParts.length > 1 ? dateParts.last : "";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                transaction.type ?? "",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                  color: AppColors.lightTextPrimary,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(0, -2),
                  child: Text(
                    _getAmountPrefix(transaction.isPlus),
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp,
                      color: _getAmountColor(transaction.isPlus),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${transaction.trxCurrencySymbol}${double.tryParse(transaction.amount!.replaceAll(",", ""))!.toStringAsFixed(calculateDecimals)}",
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp,
                      color: _getAmountColor(transaction.isPlus),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 15.sp,
                color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 15.sp,
                color: AppColors.lightTextPrimary.withValues(alpha: 0.30),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    final localization = AppLocalizations.of(context)!;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.homeTransactionDetailsDescription,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
              color: AppColors.lightTextPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.transaction.description ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              letterSpacing: 0,
              fontWeight: FontWeight.w700,
              color: AppColors.lightTextPrimary.withValues(alpha: 0.80),
            ),
          ),
        ],
      ),
    );
  }
}
