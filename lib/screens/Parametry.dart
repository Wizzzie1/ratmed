import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Parametry extends StatefulWidget {
  final pageIndex = PageController(initialPage: 2);
  @override
  _ParametryState createState() => _ParametryState();
}
class _ParametryState extends State<Parametry> {
  int years = 20;
  int height = 100;
  int weight;
  int bloodPressure;
  int pulse;
  String breaths = '';

  void breathing() {
    if(years<=1) {
      breaths = '40-60/min';
    }
    if(years<2) {
      breaths = '30-40/min';
    }
    if(years>=2&&years<=5) {
      breaths = '20-25/min';
    }
    if(years>=12) {
      breaths = '12-20/min';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parametry życiowe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Text(
              "Wybierz wiek",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  years.toString(),
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900, color: Colors.black),
                ),
                Text(
                    "lat",
                )
              ],
            ),
            Slider(
              value: years.toDouble(),
              min: 1,
              max: 110,
              activeColor: Colors.red,
              onChanged: (double value) {
                setState(() {
                  years = value.round();
                  breathing();
                  if(years<=11) {
                    height = 100;
                  }
                  if(years<=18) {
                    weight = 3*years+7;
                  } else {
                    weight = ((height - 100) * 0.85).toInt();
                  }
                });
              },
            ),
            Center(
              child: Padding(
              padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Wybierz wzrost",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  height.toString(),
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900, color: Colors.black),
                ),
                Text(
                  "cm",
                )
              ],
            ),
            Slider(
              value:  height.toDouble(),
              min: years>=20 ? 100 : 40,
              max: years<=10 ? 170 : 210,
              activeColor: Colors.redAccent,
              onChanged: (double value) {
                setState(() {
                  if(years<=11) {
                    height = value.round() - 90;
                  }
                  height = value.round();
                  if(years<=18) {
                    weight = 3*years+7;
                  } else {
                    weight = ((height - 100) * 0.90).toInt();
                  }
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  'Waga:',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.redAccent,),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    weight.toString() + " kg",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  'Ilość oddechów:',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.redAccent,),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                  breaths.toString(),
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}