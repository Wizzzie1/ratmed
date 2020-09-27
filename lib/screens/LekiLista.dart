import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pracainzynierska/data/lists/listaLeki.dart';
import 'package:pracainzynierska/screens/Algorytmy.dart';
import 'package:pracainzynierska/screens/Lek.dart';
import 'package:pracainzynierska/screens/Parametry.dart';
import 'package:pracainzynierska/screens/test2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pracainzynierska/screens/test.dart';

class LekiLista extends StatefulWidget {
  final pageIndex = PageController(initialPage: 0);
  @override
  _LekiListaState createState() => _LekiListaState();
}


class _LekiListaState extends State<LekiLista> {


  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _searchListItems;

  _LekiListaState() {
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

  int _currentindex = 0;
  final tabs = [
    testowa(),
    testowa2(),
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
    lekiLista lek = new lekiLista();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Leki'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Algorytmy'),
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            title: Text('Parametry'),
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
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
    lekiLista lek = new lekiLista();
    final topColor = const Color(0xff1c4d8c);
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
          itemCount: lek.leki.length,
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        lek.leki[index],
                        style: TextStyle(color: titleColor, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                onTap: () {

                  var route = new MaterialPageRoute(
                      builder: (BuildContext context) => new LekScreen(
                            text: lek.leki[index],
                          ));
                  Navigator.of(context).push(route);
                });
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }

  Widget _searchListView() {
    lekiLista lek = new lekiLista();
    _searchListItems = new List<String>();
    for (int i = 0; i < lek.leki.length; i++) {
      var item = lek.leki[i];

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
    lekiLista lek = new lekiLista();
    return new Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: divHeight / 1.58,
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
                      ),
                    ],
                  ),
                  onTap: () {
                    final snackBar = SnackBar(content: Text(lek.leki[index]));
                    Scaffold.of(context).showSnackBar(snackBar);

                    var route = new MaterialPageRoute(
                        builder: (BuildContext context) => new LekScreen(
                          text: lek.leki[index],
                        ));
                    Navigator.of(context).push(route);
                  });
            },
            separatorBuilder: (context, index) {
              return Divider();
            }),
      ),
    );
  }
}
