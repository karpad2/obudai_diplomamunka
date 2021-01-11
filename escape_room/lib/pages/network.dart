import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:wifi/wifi.dart';

class Network_Route extends StatefulWidget {
  Network_Route({Key key}) : super(key: key);

  @override
  _Network_Route createState() => _Network_Route();
}

class _Network_Route extends State<Network_Route> {
  //Future<Album> futureAlbum;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getDataFromUi();
    //futureAlbum = fetchAlbum();
  }

  getDataFromUi() async {
    loading = false;
    //await ApiData.getData();
    setState(() {
      loading = true;
      main();
    });
  }

  void main() async {
    const port = 80;
    final stream = NetworkAnalyzer.discover2(
      '192.168.1',
      port,
      timeout: Duration(milliseconds: 2000),
    );

    int found = 0;
    stream.listen((NetworkAddress addr) {
      // print('${addr.ip}:$port');
      if (addr.exists) {
        found++;
        print('Found device: ${addr.ip}:$port');
      }
    }).onDone(() => print('Finish. Found $found device(s)'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hálózat"),
        ),
        body: Center(
          child: Text('Hálózat'),
        ));
  }
}
