import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/authentication/firstData.dart';



class FirstTime extends StatefulWidget {

  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {

Widget _sendFirstData(){
  return RawMaterialButton(
        constraints: BoxConstraints(minHeight: 60),
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () async {
         
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FirstData()));
        },
        child: Text("     Weiter     ",
            style: Theme.of(context).textTheme.headline2));}

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          backgroundColor: bgColor,
          body: Column(children: [
            Column(
              children: [
                Container(
                  height: 90,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Hi Sportsfreund!',
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Schön dich zu sehen - bevor es los geht brauchen wir noch ein paar Infos über dich, um dir ein optimales Sporterlebnis zu bieten. Alle Angaben kannst du später unter Einstellungen wieder ändern',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                ),
                _sendFirstData(),
              ],
            ),
           
          ]),
        ));
  }
}