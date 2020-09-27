import 'package:flutter/material.dart';
import 'package:pracainzynierska/screens/Algorytmy.dart';
import 'package:pracainzynierska/screens/LekiLista.dart';
import 'package:pracainzynierska/screens/Parametry.dart';
import 'package:pracainzynierska/screens/menu.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Menu",
        theme: new ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MenuScreen(),
        routes: <String, WidgetBuilder>{
          '0': (BuildContext context) => LekiLista(),
          '1': (BuildContext context) => AlgorytmyMenu(),
          '2': (BuildContext context) => Parametry(),
        });
  }
}
