import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'homescreen.dart';
import 'profile.dart';

class workout extends StatefulWidget {
  createState() {
    return _workoutState();
  }
}

class _workoutState extends State<workout> {
  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  static final CameraPosition  initialLocation = CameraPosition(
    target: LatLng (49.017214,12.097498),
    zoom: 14.6,);


  Widget build(context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
        backgroundColor: barColor,
      ),
      
      
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
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
            if (_currentIndex == 1)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            if (_currentIndex == 0)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile()),
              );
          });
        },
      ),
    );
  }
}
