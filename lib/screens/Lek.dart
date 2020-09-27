import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:async';
import 'package:pracainzynierska/screens/LekiLista.dart';



void main() {
  runApp(MaterialApp(
    home: LekScreen(),
  ));
}

class LekScreen extends StatefulWidget {
  final String text;
  LekScreen({Key key, @required this.text}) : super(key: key);
  @override
  _LekScreenState createState() => _LekScreenState();
}

class _LekScreenState extends State<LekScreen> {
  var my_data;
  bool expanded = false;
  String dawkowanie = '';
  String przeciwwskazania = '';
  String dawkaDorosliTxt = '';
  String dawkaDzieciTxt = '';
  String kiedyTxt = '';
  String ilosc = '';
  var decoded;
  var liczba;
  var ikonka=0;
  TextEditingController input1 = new TextEditingController();
  TextEditingController input2 = new TextEditingController();
  String input11 ;
  String input22;
  var field1;
  var field2;
  var wynik = 'Uzupełnij dane';
  var wynikdzieci;
  var drogapodania = "";
  var s;

  loadAsset() async {
    var dane;
    var tekst2;

    dane = await rootBundle.loadString('assets/data.json');
    tekst2 = json.decode(dane);

    setState(() {
      dawkaDorosliTxt = tekst2[widget.text]['dawkaDorosli'];
      dawkaDzieciTxt = tekst2[widget.text]['dawkaDzieci'];
      kiedyTxt = tekst2[widget.text]['kiedy'];
      ilosc = tekst2[widget.text]['przeciwwskazaniaGrupy'][0]['ile'];
      liczba = int.parse(ilosc);
      decoded = tekst2;
      ikonka=0;
      drogapodania = decoded[widget.text]['drogaPodania'];
    });
  }


   icon() {
    if(ikonka<=liczba){
      if(ikonka == liczba) {
        ikonka = 0;
      }
      if(decoded[widget.text]['przeciwwskazaniaGrupy'][0]['przeciwwskazania'][ikonka]['grupa'] == '1') {
        ikonka++;
        return Icon(Icons.mood_bad);
      }
       else if( decoded[widget.text]['przeciwwskazaniaGrupy'][0]['przeciwwskazania'][ikonka]['grupa'] == '2') {
        ikonka++;
        return Icon(Icons.favorite);
      }
      else if (decoded[widget.text]['przeciwwskazaniaGrupy'][0]['przeciwwskazania'][ikonka]['grupa'] == '3') {
        ikonka++;
        return Icon(Icons.healing);
      }
    }
  }

  calculator() {
    if(field1>=18) {
      setState(() {
        wynik = decoded[widget.text]['dawkaDorosliKalkulator'] + ' mg';
        drogapodania = decoded[widget.text]['drogaPodania'];
        s = drogapodania;
        print(s);
      });
    }
    if(field1 < 18) {
      if(decoded[widget.text]['dawkaDzieciKalkulator'] == "") {
        setState(() {
          wynik = "Nie podawać u dzieci!";
        });
      } else {
        setState(() {
          wynik = decoded[widget.text]['dawkaDzieciKalkulator'];
          wynikdzieci = double.parse(wynik);
          wynikdzieci = wynikdzieci * field2;
          var pomocnicza = wynikdzieci.toString();
          wynik = pomocnicza;
          drogapodania = decoded[widget.text]['drogaPodania'];
          s = drogapodania;
          print(s);
        });
      }
      }
  }


  @override
  void initState() {
    loadAsset();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var divHeight = MediaQuery.of(context).size.height;
    var divWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    final topColor = const Color(0xff092e58);
    return MaterialApp(
      home: Container(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                      border: Border(bottom: BorderSide(color: Colors.grey, width: 0.8))),
                  child: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue,
                    labelPadding: EdgeInsets.only(bottom: 2),
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(icon: Icon(Icons.calendar_today),),
                      Tab(icon: Icon(Icons.exposure)),
                      Tab(icon: Icon(Icons.rate_review)),
                    ],
                  ),
                ),
              ),
              title: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(widget.text, style: TextStyle(color: Colors.black, fontSize: 35, letterSpacing: 1),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(kiedyTxt, style: TextStyle(color: Colors.grey, fontSize: 15, letterSpacing: 0.2), textAlign: TextAlign.left,),
                    ],
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            body:  TabBarView(
              children: [
                Column(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(28.0),
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.accessibility, size: 50,),
                         Padding(
                           padding: const EdgeInsets.only(left: 12),
                           child: Text(dawkaDorosliTxt, style: TextStyle(fontSize: 20),),
                         ),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(28.0),
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.child_care, size: 50,) ,
                         Padding(
                           padding: const EdgeInsets.only(left: 12),
                           child: Text(dawkaDzieciTxt, style: TextStyle(fontSize: 20),),
                         ),
                       ],
                     ),
                   )
                 ],
                ),
                Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        itemCount: liczba,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: icon(),
                            title: Text(decoded[widget.text]['przeciwwskazaniaGrupy'][0]['przeciwwskazania'][index]['przeciwwskazanie']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    TextFormField(
                      controller: input1,
                      onChanged: (text) {
                        setState(() {
                          input11 = input1.text;
                          field1 = double.parse(input11);
                          calculator();
                        });
                      },
                      style: TextStyle(fontSize: 30),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Wiek (w latach)',
                          labelStyle: TextStyle(fontSize: 20)
                      ),
                    ),
                    TextFormField(
                      controller: input2,
                      onChanged: (text) {
                        setState(() {
                          input22 = input2.text;
                          field2 = double.parse(input22);
                          calculator();
                        });
                      },
                      style: TextStyle(fontSize: 30),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Waga (kg)',
                        labelStyle: TextStyle(fontSize: 20)
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, right: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.format_list_numbered,
                                      size: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Dawka",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Text(
                                        wynik,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30),
                                        child: Icon(
                                          Icons.mood,
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Droga podania",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(drogapodania)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

