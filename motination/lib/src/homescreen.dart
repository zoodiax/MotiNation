import 'package:flutter/material.dart';
import 'workout.dart';



class App extends StatelessWidget {
  
  Widget build(context) {
    return MaterialApp(
      home: new HomeScreen());
  }
}

class HomeScreen extends StatelessWidget{

  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  Widget build(context) {
    return new Scaffold(
        
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
            child: FlatButton(
            child: Icon(Icons.fitness_center,size: 88,color: bgColor,),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => workout()),
              );
            },)
            
          )
        ),
        /*bottomNavigationBar: BottomNavigationBar(items: 
        [BottomNavigationBarItem(icon: Icon(Icons.home)
        title: Text('home')),*/
        
    );
  }

}

/*

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

*/