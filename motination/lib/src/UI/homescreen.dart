import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'running.dart';



class HomeScreen extends StatefulWidget {
  @override
  createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  
  final barColor = const Color(0xFF0A79DF);
 
 

  Widget _info() {
    return RawMaterialButton(
        fillColor: blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: blue)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Running()),
          );
        },
        child: Text("     Auf geht's!     ",
            style: Theme.of(context).textTheme.headline2));
  }

  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
         backgroundColor: bgColor,
          
          
          body: Column(children: [
            Expanded(
              flex: 10,
              child: 
              Column(children: [
                Spacer(flex: 4),
                Container(
                child: Center(
                  
                  child: Text(
                    'Willkommen bei Motination!',
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                  
                    'Lieblingssport machen, Punkte in Running oder Workout sammeln und coole Prämien absahnen',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(flex: 2),

              ],)
            ),
            
            Spacer(flex: 2),
            Expanded(flex: 1, child: _info()),
            Spacer(flex: 2),
          ]),
        ));
  }
}
