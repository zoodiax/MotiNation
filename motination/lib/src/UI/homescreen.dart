import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'workout.dart';
import 'profile.dart';
import 'shop.dart';

/*geschlöscht und in main.dart eingefügt
class MyApp extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(home: new HomeScreen());
  }
}*/

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
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: barColor,
              ),
              width: 177,
              height: 155,
              child: FlatButton(
                child: Icon(
                  Icons.fitness_center,
                  size: 88,
                  color: bgColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Workout()),
                  );
                },
              ))),
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
            icon: Icon(Icons.shopping_basket),
            title: Text('Shop'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 2)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shoping()),
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
