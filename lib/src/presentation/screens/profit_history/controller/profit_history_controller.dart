import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:qunzo_agent/src/network/api/api_path.dart';
import 'package:qunzo_agent/src/network/response/status.dart';
import 'package:qunzo_agent/src/network/service/network_service.dart';
import 'package:qunzo_agent/src/presentation/screens/transactions/model/transactions_model.dart';

class ProfitHistoryController extends GetxController {
  // Global Variable
  final RxBool isLoading = false.obs;
  final RxBool isPageLoading = false.obs;
  final RxBool isTransactionsLoading = false.obs;
  final RxBool isFilter = false.obs;
  final Rx<TransactionsModel> transactionsModel = TransactionsModel().obs;

  // Transactions ID
  final transactionIdController = TextEditingController();

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxBool hasMorePages = true.obs;

  // Build query parameters for filtering
  List<String> _buildQueryParams() {
    final queryParams = <String>[];
    queryParams.add('page=${currentPage.value}&per_page=15');

    if (transactionIdController.text.isNotEmpty) {
      queryParams.add(
        'txn=${Uri.encodeComponent(transactionIdController.text)}',
      );
    }

    return queryParams;
  }

  // Fetch Transactions From API
  Future<void> fetchTransactions() async {
    try {
      isLoading.value = true;
      currentPage.value = 1;
      hasMorePages.value = true;

      final response = await Get.find<NetworkService>().get(
        endpoint:
            '${ApiPath.transactionsEndpoint}?type=agent-profit&page=${currentPage.value}&per_page=15',
      );

      if (response.status == Status.completed) {
        transactionsModel.value = TransactionsModel.fromJson(response.data!);
        if (transactionsModel.value.data!.transactions!.length <
            transactionsModel.value.data!.meta!.perPage!) {
          hasMorePages.value = false;
        }
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchTransactions() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Dynamic Transactions
  Future<void> fetchDynamicTransactions() async {
    try {
      isTransactionsLoading.value = true;
      currentPage.value = 1;
      hasMorePages.value = true;

      final queryParams = _buildQueryParams();
      final endpoint =
          '${ApiPath.transactionsEndpoint}?type=agent-profit&${queryParams.join('&')}';
      final response = await Get.find<NetworkService>().get(endpoint: endpoint);

      if (response.status == Status.completed) {
        transactionsModel.value = TransactionsModel.fromJson(response.data!);
        if (transactionsModel.value.data!.transactions == null ||
            transactionsModel.value.data!.transactions!.isEmpty) {
          transactionsModel.value.data!.transactions = [];
          hasMorePages.value = false;
        } else if (transactionsModel.value.data!.transactions!.length <
            transactionsModel.value.data!.meta!.perPage!) {
          hasMorePages.value = false;
        }
      } else {
        transactionsModel.value.data!.transactions = [];
        hasMorePages.value = false;
      }
    } catch (e, stackTrace) {
      debugPrint('❌ fetchDynamicTransactions() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isTransactionsLoading.value = false;
      isFilter.value = false;
    }
  }

  // Fetch More Transactions
  Future<void> loadMoreTransactions() async {
    if (!hasMorePages.value || isPageLoading.value) return;
    isPageLoading.value = true;
    currentPage.value++;

    try {
      final queryParams = _buildQueryParams();
      final endpoint =
          '${ApiPath.transactionsEndpoint}?type=agent-profit&${queryParams.join('&')}';
      final response = await Get.find<NetworkService>().get(endpoint: endpoint);

      if (response.status == Status.completed) {
        final newTransactions = TransactionsModel.fromJson(response.data!);

        if (newTransactions.data!.transactions!.isEmpty) {
          hasMorePages.value = false;
        } else {
          transactionsModel.value.data!.transactions!.addAll(
            newTransactions.data!.transactions!,
          );
          transactionsModel.refresh();
          if (newTransactions.data!.transactions!.length <
              transactionsModel.value.data!.meta!.perPage!) {
            hasMorePages.value = false;
          }
        }
      }
    } catch (e, stackTrace) {
      currentPage.value--;
      debugPrint('❌ loadMoreTransactions() error: $e');
      debugPrint('📍 StackTrace: $stackTrace');
      ToastHelper().showErrorToast(
        AppLocalizations.of(Get.context!)!.allControllerLoadError,
      );
    } finally {
      isPageLoading.value = false;
    }
  }

  // Clear other filters when type is changed
  void clearOtherFiltersOnTypeChange() {
    transactionIdController.clear();
  }
}
