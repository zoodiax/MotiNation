import 'package:flutter/material.dart';

  
void main(){
  var app = MaterialApp(
    title: 'FLutter App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.greenAccent,
      accentColor: Colors.blue,
    ),

    home: Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),

    body: Center(    
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('I am in the Center'),
          Text('i am in the background'),
          RaisedButton(
            onPressed: (){},
            child: Text('Login'),
            color: Colors.green,
            splashColor: Colors.blue,
          )
        ],
      )
      
    ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,

          ),

        ),
     ),
  );

runApp(app);
}     




