import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get connected;
}

class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this.connectivity);
  final InternetConnectionChecker connectivity;
  @override
  Future<bool> get connected => connectivity.hasConnection;
}
