import 'package:flutter/material.dart';
import 'package:escape_room/pages/about.dart';
import 'package:escape_room/pages/network.dart';
import 'package:escape_room/pages/users.dart';

void main() => runApp(MyApplication());

class MyApplication extends StatelessWidget {
  final appTitle = 'Escape Room';
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: appTitle,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String title = "Escape Room";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Main page!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Main Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Users'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Users()));
              },
              //Navigator.pop(context);
              //},
            ),
            ListTile(
              leading: Icon(Icons.wifi),
              title: Text('Networks'),
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Network_Route()));
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => About_us()));
              },
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
