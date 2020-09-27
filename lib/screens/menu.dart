import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pracainzynierska/screens/Algorytmy.dart';
import 'package:pracainzynierska/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pracainzynierska/screens/LekiLista.dart';
import 'package:pracainzynierska/screens/Parametry.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    final topColor = const Color(0xff092e58);
    final fontColor = const Color(0xff092e58);

    List<String> titles = ['Leki', 'Algorytmy', 'Parametry'];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          new Container(
              width: divWidth,
              height: divHeight / 0.6,
              decoration: BoxDecoration(
                color: topColor,
              ),
              child: Container(
                margin:
                    EdgeInsets.only(top: divHeight / 10, left: divWidth / 15),
                child: Text(
                  'Aplikacja dla ratowników medycznych',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              )),
          new Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: divHeight / 3),
            width: divWidth,
            height: divHeight / 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(250.0)),
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: divHeight / 4),
            width: 400,
            child: new GridView.builder(
                itemCount: titles.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    elevation: 15.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: new InkResponse(
                      child: new Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          titles[index],
                          style: TextStyle(
                              color: fontColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pushNamed('$index');
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
