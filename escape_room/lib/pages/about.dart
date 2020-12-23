import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
/*
void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: About_us(),
  ));
}*/


class About_us extends StatefulWidget {
  About_us({Key key}) : super(key: key);

  @override
  _About_us createState() => _About_us();
}

class _About_us extends State<About_us> {
  //Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    String appName="";
    String packageName="" ;
    String version="";
    String buildNumber="";

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("About us"),
      ),
      body:
        Center(
         child: Text('Készítette: Kovács Árpád, \nBPJZ56\nVerzió szám: $version'),
        )
    );
  }
}
