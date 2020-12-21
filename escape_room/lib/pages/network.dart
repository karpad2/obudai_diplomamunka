import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';

class Network_Route extends StatelessWidget {
//  final WifiInfo _wifiInfo = await WifiInfo();
  //final Connectivity _connectivity = Connectivity();
  void  net() {
    final String ip = (String) Wifi.ip;
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network Route'),
      ),
      body: ListView(
        children: <Widget>[
          Text("IP address:"),
          SizedBox()
        ],
      ),
    );
  }
}
