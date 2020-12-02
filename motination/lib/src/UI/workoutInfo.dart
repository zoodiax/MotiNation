import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:flutter/material.dart';
import 'workout.dart';

class WorkoutInfo extends StatefulWidget {
  @override
  createState() {
    return _WorkoutInfoState();
  }
}

class _WorkoutInfoState extends State<WorkoutInfo> {
  
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
            MaterialPageRoute(builder: (context) => Workout()),
          );
        },
        child: Text("     Weiter     ",
            style: Theme.of(context).textTheme.headline2,));
  }

  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
         backgroundColor: bgColor,
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   title: Text('Motination ',
          //       style: GoogleFonts.spartan(
          //           textStyle: TextStyle(
          //               color: Colors.black,
          //               fontSize: 25,
          //               fontWeight: FontWeight.w600))),
          //   backgroundColor: bgColor,
           
          // ),
          body: Column(children: [
            Expanded(
              flex: 10,
              child: 
              Column(children: [
                Spacer(flex: 4),
                Container(
                child: Center(
                  child: Text(
                    'Motination Workout!',
                    style:  Theme.of(context).textTheme.headline1,
                  ),
                
                ),
              ),
              Spacer(),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                  
                    'Besuche oder entdecke ein Sportzentrum in deiner Nähe und erhalte pro Besuch 10 Punkte',
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
