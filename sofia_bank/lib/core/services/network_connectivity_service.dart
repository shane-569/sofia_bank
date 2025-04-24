import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityService {
  static final NetworkConnectivityService _instance =
      NetworkConnectivityService._internal();
  factory NetworkConnectivityService() => _instance;
  NetworkConnectivityService._internal();

  final _connectivity = Connectivity();
  final _controller = StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get connectivityStream => _controller.stream;

  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(result);
    });
  }

  void dispose() {
    _controller.close();
  }
}
