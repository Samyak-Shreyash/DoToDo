//import 'package:connectivity/connectivity.dart';
//
//class ConnectionInfo {
//  // ignore: non_constant_identifier_names
//  String ConnectionStatus;
//
//  Future<String> getConnectionInfo() async {
//    await connectionStatus();
//    print('Here');
//    print(this.ConnectionStatus);
//    print('Not this');
//    return this.ConnectionStatus;
//  }
//}
//
//Future connectionStatus() async {
//  // ignore: non_constant_identifier_names
//  String Connections = '';
//  var connectivityResult = await (Connectivity().checkConnectivity());
//  if (connectivityResult == ConnectivityResult.mobile) {
//    ConnectionInfo().ConnectionStatus = 'Mobile Connection';
//  } else if (connectivityResult == ConnectivityResult.wifi) {
//    ConnectionInfo().ConnectionStatus = 'Wifi Connection';
//  }
//}
