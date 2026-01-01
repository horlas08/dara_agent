import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_agent/l10n/app_localizations.dart';
import 'package:qunzo_agent/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_agent/src/common/widgets/common_loading.dart';
import 'package:qunzo_agent/src/helper/toast_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String paymentUrl;

  const WebViewScreen({super.key, required this.paymentUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController _controller = WebViewController();
  bool _isLoading = true;
  bool _redirectProcessed = false;
  final localization = AppLocalizations.of(Get.context!)!;
  @override
  void initState() {
    super.initState();

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              _isLoading = false;
            });

            if (url.contains('/status/success')) {
              String jsonResponse =
                  await _controller.runJavaScriptReturningResult(
                        "document.body.innerText",
                      )
                      as String;

              jsonResponse = jsonResponse.trim();

              if (jsonResponse.startsWith('"') && jsonResponse.endsWith('"')) {
                jsonResponse = jsonResponse.substring(
                  1,
                  jsonResponse.length - 1,
                );
              }
              jsonResponse = jsonResponse.replaceAll(r'\"', '"');
              final decoded = jsonDecode(jsonResponse);
              final status = decoded['status']?.toLowerCase();
              if (!_redirectProcessed) {
                _redirectProcessed = true;
                if (status == 'success') {
                  Get.back(result: {'success': true, 'data': decoded});
                  ToastHelper().showSuccessToast(
                    localization.webViewPaymentSuccess,
                  );
                } else {
                  Get.back(result: {'success': false});
                  ToastHelper().showErrorToast(
                    localization.webViewPaymentFailed,
                  );
                }
              }
            } else if (url.contains('/cancel')) {
              String jsonResponse =
                  await _controller.runJavaScriptReturningResult(
                        "document.body.innerText",
                      )
                      as String;

              jsonResponse = jsonResponse.trim();

              if (jsonResponse.startsWith('"') && jsonResponse.endsWith('"')) {
                jsonResponse = jsonResponse.substring(
                  1,
                  jsonResponse.length - 1,
                );
              }
              jsonResponse = jsonResponse.replaceAll(r'\"', '"');
              final decoded = jsonDecode(jsonResponse);
              final status = decoded['status']?.toLowerCase();
              if (!_redirectProcessed) {
                _redirectProcessed = true;
                if (status == "failed") {
                  Get.back(result: {'success': false});
                  ToastHelper().showErrorToast(decoded["message"]);
                }
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back();
          ToastHelper().showErrorToast(localization.webViewPaymentCancelled);
        }
      },
      child: Scaffold(
        appBar: CommonDefaultAppBar(),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const CommonLoading(),
          ],
        ),
      ),
    );
  }
}
