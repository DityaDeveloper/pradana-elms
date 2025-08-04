import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  // Singleton instance
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() {
    return _instance;
  }
  NetworkService._internal();

  final Connectivity _connectivity = Connectivity();

  // Check if the device is currently connected to the internet
  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _isNetworkAvailable(connectivityResult.first);
  }

  // Stream to listen for network status changes
  Stream<bool> get networkStatusStream async* {
    await for (final connectivityResult
        in _connectivity.onConnectivityChanged) {
      yield _isNetworkAvailable(connectivityResult.first);
    }
  }

  // Helper method to determine if the network is available based on the ConnectivityResult
  bool _isNetworkAvailable(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }
}
