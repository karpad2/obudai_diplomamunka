import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _Users createState() => _Users();
}

class _Users extends State<Users> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Felhasználók"),
        ),
        body: Center(
          child: Text('Felhasználók'),
        ));
  }
}
