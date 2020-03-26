import 'package:flutter/material.dart';
import 'homescreen.dart';



class workout extends StatelessWidget{
 final barColor = const Color(0xFF0A79DF);
  Widget build(context){
    return new Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.home),
            backgroundColor: barColor,
            onPressed: () {
              Navigator.pop(context );
            }),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), 
            ),
            width: 177,
            height: 155,
            child: Text('Map'),
            
          )
        ),
    
    );
  }


}



