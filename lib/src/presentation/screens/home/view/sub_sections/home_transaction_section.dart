import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/src/app/constants/app_colors.dart';
import 'package:qunzo_agent/src/common/service/settings_service.dart';
import 'package:qunzo_agent/src/helper/dynamic_decimals_helper.dart';
import 'package:qunzo_agent/src/presentation/screens/home/controller/home_controller.dart';
import 'package:qunzo_agent/src/presentation/screens/home/view/sub_sections/home_transaction_details.dart';
import 'package:qunzo_agent/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_agent/src/presentation/widgets/transaction_dynamic_icon.dart';
import 'package:qunzo_agent/src/presentation/widgets/transactions_dynamic_color.dart';

class HomeTransactionSection extends StatelessWidget {
  const HomeTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return homeController.dashboardModel.value.data!.transactions!.isEmpty
        ? NoDataFound()
        : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final transaction = homeController
                  .dashboardModel
                  .value
                  .data!
                  .transactions![index];

              final calculateDecimals = DynamicDecimalsHelper()
                  .getDynamicDecimals(
                    currencyCode: transaction.trxCurrencyCode!,
                    siteCurrencyCode: Get.find<SettingsService>().getSetting(
                      "site_currency",
                    )!,
                    siteCurrencyDecimals: Get.find<SettingsService>()
                        .getSetting("site_currency_decimals")!,
                    isCrypto: transaction.isCrypto!,
                  );

              return InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  Get.bottomSheet(
                    HomeTransactionDetails(transaction: transaction),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
                      width: 1.5.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 42.w,
                              height: 42.w,
                              decoration: BoxDecoration(
                                color:
                                    TransactionDynamicColor.getTransactionColor(
                                      transaction.type,
                                    ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                  transaction.type == "Cash In"
                                      ? 12.r
                                      : transaction.type == "Cash Received"
                                      ? 10.r
                                      : transaction.type == "Exchange"
                                      ? 12.r
                                      : transaction.type == "Deposit"
                                      ? 12.r
                                      : transaction.type == "Credit"
                                      ? 12.r
                                      : transaction.type == "Cash In Commission"
                                      ? 10.r
                                      : 8.r,
                                ),
                                child: Image.asset(
                                  TransactionDynamicIcon.getTransactionIcon(
                                    transaction.type,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.type ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.sp,
                                      color: AppColors.lightTextPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    transaction.createdAt!.split(",").first,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontSize: 14.sp,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.30),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        "${transaction.trxCurrencySymbol}${double.tryParse(transaction.amount!.replaceAll(",", ""))!.toStringAsFixed(calculateDecimals)}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          letterSpacing: 0,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.sp,
                          color: transaction.isPlus == true
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 12.h);
            },
            itemCount:
                homeController.dashboardModel.value.data!.transactions!.length,
          );
  }
}
