import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class NetworkConnectivityService {
  final _connectivity = Connectivity();
  final _controller = StreamController<ConnectivityResult>.broadcast();

  NetworkConnectivityService();

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
