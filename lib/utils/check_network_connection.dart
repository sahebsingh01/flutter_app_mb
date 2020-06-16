import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dialog_utils.dart';
import 'localization/localization.dart';

final Connectivity _connectivity = Connectivity();
String _connectionStatus;
Future<bool>checkNetworkConnection(BuildContext context) async {
  String connectionStatus;

  try {
    connectionStatus = (await _connectivity.checkConnectivity()).toString();
  } on PlatformException catch (_) {
    connectionStatus = Localization.of(context).internetConnectionFailed;
  }

  _connectionStatus = connectionStatus;
  print("InitConnectivity : $_connectionStatus");
  if (_connectionStatus == "ConnectivityResult.mobile" ||
      _connectionStatus == "ConnectivityResult.wifi") {
    return true;
  } else {
    DialogUtils.displayToast(Localization.of(context).internetNotConnected);
    return false;
  }
}
