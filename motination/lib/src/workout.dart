import 'package:flutter/material.dart';


class workout extends StatelessWidget{
  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.fitness_center),
            backgroundColor: barColor,
            onPressed: () {}),
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('MotiNation'),
          backgroundColor: barColor,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: barColor,
            ),
            width: 177,
            height: 155,
            child: Text('Map'),
            
          )
        ),
    )
  }


}
