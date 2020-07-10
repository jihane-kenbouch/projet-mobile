import 'package:flutter/material.dart';
import 'package:flutter_app_cinema/setting-page.dart';
import 'package:flutter_app_cinema/villes-page.dart';

import 'MenuItem.dart';
import 'login.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    appBarTheme: AppBarTheme(color: Colors.redAccent
    ),
  ),
  home: login(),
));
class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final menus = [
    {'title': 'Home', 'icon': Icon(Icons.home), 'page': VillePage()},
    {'title': 'Map', 'icon': Icon(Icons.location_on), 'page': SettingPage()},
    {'title': 'Contact', 'icon': Icon(Icons.contact_mail), 'page': SettingPage()},
  ];

  @override
Widget build(BuildContext context){
  return Scaffold(
    backgroundColor: Colors.redAccent[700],
      appBar: AppBar(
      title: Text("Cinema Page"),
  ),
  body: Center(
    child: CircleAvatar(
      backgroundImage: AssetImage("./image/cinema.jpg"),
      radius: 180,

    ),
  ),
    drawer: Drawer(
      child: ListView(
          children: <Widget>[
      DrawerHeader(

          child: Center(
            child: CircleAvatar(
              backgroundImage: AssetImage("./image/profiles.jpg"),
              radius: 50,

    ),
          ),
  decoration: BoxDecoration(
  gradient:
  LinearGradient(colors: [Colors.grey, Colors.redAccent[700]]
  )
  ),
  ),

  ...this.menus.map((item) {
    return new Column(
    children: <Widget>[
    Divider(
    color: Colors.red,
    ),
    MenuItem(item['title'], item['icon'], (context) {
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => item['page']
    ));
    })
    ],
    );
    })
    ],
    ),
    ),
    );
    }
}
