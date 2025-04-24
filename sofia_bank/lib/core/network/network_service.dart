import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sofia_bank/core/constants/api_endpoints.dart';
import 'package:sofia_bank/core/network/api_error_handler.dart';
import 'package:sofia_bank/core/network/dio_auth_interceptor.dart';
import 'package:sofia_bank/core/network/dio_network_interceptor.dart';
import 'package:sofia_bank/core/services/network_connectivity_service.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();

  late final Dio _dio;
  late final NetworkConnectivityService _connectivityService;

  void initialize(BuildContext context) {
    _connectivityService = NetworkConnectivityService();
    _connectivityService.initialize();

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll([
      DioNetworkInterceptor(
        context: context,
        connectivityService: _connectivityService,
      ),
      DioAuthInterceptor(),
    ]);
  }

  // GET request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handling
  Exception _handleError(DioException error) {
    final errorMessage = ApiErrorHandler.handleError(error);
    return Exception(errorMessage);
  }

  Dio get dio => _dio;
  NetworkConnectivityService get connectivityService => _connectivityService;

  void dispose() {
    _connectivityService.dispose();
  }
}
