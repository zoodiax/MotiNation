import 'package:flutter/material.dart';
import 'workout.dart';
import 'homescreen.dart';

class profile extends StatefulWidget {
  @override
  createState() {
    return _profileState();
  }
}

class _profileState extends State<profile> {
  int _currentIndex = 0;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  Widget build(context) {
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Profile '),
        backgroundColor: barColor,
      ),
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
            icon: Icon(Icons.fitness_center),
            title: Text('Workout'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (_currentIndex == 2)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => workout()),
              );
            if (_currentIndex == 1)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
          });
        },
      ),
    );
  }
}
