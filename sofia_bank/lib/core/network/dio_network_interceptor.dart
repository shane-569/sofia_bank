import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sofia_bank/core/services/network_connectivity_service.dart';
import 'package:sofia_bank/features/common/presentation/pages/no_internet_page.dart';

class DioNetworkInterceptor extends Interceptor {
  final NetworkConnectivityService _connectivityService;
  final BuildContext context;

  DioNetworkInterceptor({
    required this.context,
    NetworkConnectivityService? connectivityService,
  }) : _connectivityService =
            connectivityService ?? NetworkConnectivityService();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasConnection = await _connectivityService.checkConnectivity();
    if (!hasConnection) {
      _showNoInternetDialog();
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection',
        ),
      );
    }
    return handler.next(options);
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: NoInternetPage(
          onRetry: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
