import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  Future<bool> checkInernetConnectivity() async {
    final connectionState = (await Connectivity().checkConnectivity());

    switch (connectionState) {
      case ConnectivityResult.ethernet:
        return true;
      case ConnectivityResult.wifi:
        return true;
      case ConnectivityResult.mobile:
        return true;

      default:
        return false;
    }
  }
}
