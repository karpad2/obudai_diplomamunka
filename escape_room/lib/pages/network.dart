import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
//import 'package:wifi/wifi.dart';



class Network_Route extends StatelessWidget {
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
          title: Text('Network'),
        ),
        body: Center(
            child:  ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Finding Devices'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.wifi),
                  title: Text('Network'),
                  onTap: () {
                    //Navigator.pop(context);
                    //Navigator.push(context,
                        //MaterialPageRoute(builder: (context) => Network_Route()));
                  },
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.push(context,
                       // MaterialPageRoute(builder: (context) => About_us()));
                  },
                ),
              ],
            ),
        ),
    );
  }
}
