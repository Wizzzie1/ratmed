import 'package:flutter/material.dart';
import 'package:pracainzynierska/data/lists/listaAlgorytmy.dart';
import 'package:pracainzynierska/screens/LekiLista.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pracainzynierska/screens/Parametry.dart';
import 'package:pracainzynierska/screens/Algorytmy.dart';

class testowa2 extends StatefulWidget {
  final pageIndex = PageController(initialPage: 1);
  @override
  _testowa2State createState() => _testowa2State();
}

class _testowa2State extends State<testowa2> {
  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _searchListItems;

  _testowa2State() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  int _currentintex = 1;
  final tabs = [
    LekiLista(),
    AlgorytmyMenu(),
    Parametry(),
  ];

  @override
  Widget build(BuildContext context) {
    final topColor = const Color(0xff092e58);
    final fontColor = const Color(0xffffffff);
    final titleColor = const Color(0xff000000);
    final subColor = const Color(0xff0080ff);
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    algorytmyLista lek = new algorytmyLista();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                width: divWidth / 1.1,
                height: divHeight / 2.4,
                decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                        color: topColor,
                        blurRadius: 10.0,
                        offset: new Offset(1.0, 0))
                  ],
                  color: topColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(75.0),
                    bottomRight: Radius.circular(75.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 68, left: 10),
                  child: new Text(
                    "Algorytmy w ratownictwie medycznym",
                    style: TextStyle(
                        color: fontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: new Column(
              children: <Widget>[
                _searchBox(),
                _isSearch ? _listView() : _searchListView()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    return new Container(
      margin: EdgeInsets.only(top: 140, left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      width: divWidth / 1.4,
      height: divHeight / 15,
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 0),
        child: new TextField(
          controller: _searchEdit,
          decoration: InputDecoration(
              hintText: 'Wyszukaj',
              fillColor: Colors.white,
              hintStyle: new TextStyle(color: Colors.grey[300]),
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff75a9f9),
              ),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              )),
        ),
      ),
    );
  }

  Widget _listView() {
    algorytmyLista lek = new algorytmyLista();
    final topColor = const Color(0xff092e58);
    final fontColor = const Color(0xffffffff);
    final titleColor = const Color(0xff000000);
    final subColor = const Color(0xff0080ff);
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;

    final List<String> saved = new List<String>();

    return new Container(
      margin: EdgeInsets.only(top: 40),
      height: divHeight / 1.822,
      width: divWidth / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
              color: topColor, blurRadius: 10.0, offset: new Offset(1.0, 10))
        ],
      ),
      child: ListView.separated(
          itemCount: lek.algorytmNazwa.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        lek.algorytmNazwa[index],
                        style: TextStyle(color: titleColor, fontSize: 25),
                      ),
                      subtitle: Text(
                        "Liczba kroków: " + lek.algorytmKroki[index],
                        style: TextStyle(color: subColor),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  final snackBar =
                  SnackBar(content: Text(lek.algorytmNazwa[index]));
                  Scaffold.of(context).showSnackBar(snackBar);
                });
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }

  Widget _searchListView() {
    algorytmyLista lek = new algorytmyLista();
    _searchListItems = new List<String>();
    for (int i = 0; i < lek.algorytmNazwa.length; i++) {
      var item = lek.algorytmNazwa[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    final topColor = const Color(0xff1c4d8c);
    final fontColor = const Color(0xffffffff);
    final titleColor = const Color(0xff000000);
    final subColor = const Color(0xff0080ff);
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    algorytmyLista lek = new algorytmyLista();
    return new Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: divHeight / 1.7,
        width: divWidth / 1.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: topColor, blurRadius: 10.0, offset: new Offset(1.0, 10))
          ],
        ),
        child: ListView.separated(
            itemCount: _searchListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          _searchListItems[index],
                          style: TextStyle(color: titleColor, fontSize: 25),
                        ),
                        subtitle: Text(
                          "Liczba kroków: " + lek.algorytmKroki[index],
                          style: TextStyle(color: subColor),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    final snackBar =
                    SnackBar(content: Text(_searchListItems[index]));
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
            },
            separatorBuilder: (context, index) {
              return Divider();
            }),
      ),
    );
  }
}
