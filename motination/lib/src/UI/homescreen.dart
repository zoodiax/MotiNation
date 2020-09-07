import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/src/UI/challenge.dart';
import 'package:motination/src/UI/mn_tile.dart';
import 'workout.dart';
import 'profile.dart';
import 'shop.dart';
import 'running.dart';

/* Homescreen Class UI Design
  Content: Logout Button, Workout Button, Running Botton, Bottom Navigation Bar
  Function: _auth.signOut(), MaterialPageRoute -> (Running, Workout, Profile, Challenge, Shop) 
*/

class HomeScreen extends StatefulWidget {
  @override
  createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final AuthService _auth = AuthService(); 
  final wrktColor = const Color (0xFF28CCD3);
  final blackColor = const Color(0xBF000000);

  Widget build(context) {
    return new Scaffold( 
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('MotiNation '),
        backgroundColor: barColor,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: bgColor,
              ),
            label: Text(
              'Logout',
              style: TextStyle(color: bgColor),
              ),
            onPressed: () async {
              await _auth.signOut();
            },
            )
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(flex: 5,),
              Container(
              width: 178,
              height: 155,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                color: blackColor, 
                child: Icon(
                  Icons.directions_run,
                  size: 88,
                  color: barColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Running()),
                  );
                },
              ),),
              Spacer(),
              Container(
              width: 178,
              height: 155,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
                color: blackColor, 
                child: Icon(
                  Icons.fitness_center,
                  size: 88,
                  color: wrktColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Workout()),
                  );
                },
              ),),
              Spacer(flex:5),
              ]
            
              ),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Challenge'),
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Shop'),
          ),
          
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 3)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shoping()),
              );
            if (_currentIndex == 2)
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Challenge()),
              );
            if (_currentIndex == 0)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
          });
        },
      ),
    );
  }
}
