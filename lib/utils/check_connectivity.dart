import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

Future<bool> hasInternet() async {
  try {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
  } on MissingPluginException catch (_) {
    // Handle the MissingPluginException
    print('Connectivity plugin not available');
    return false;
  } catch (e) {
    // Handle any other exceptions
    print('Error checking connectivity: $e');
    return false;
  }
}
