
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:location/location.dart';

class workout extends StatefulWidget {
  createState() {
    return _workoutState();
  }
}

class _workoutState extends State<workout> {
  LatLng _initialPosition = LatLng(49.017214, 12.097498);
  GoogleMapController _controller;
  Location _location = Location();
  List<Marker> allMarkers = [];
  int points ;
  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  @override
  void initState() {
   
    super.initState();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: false,
        position: LatLng(49.015982, 12.107087),
        infoWindow: InfoWindow(title: ('das Stadwerk.Hallenbad'))));

    allMarkers.add(Marker(
        markerId: MarkerId('myMarker2'),
        draggable: false,
        position: LatLng(48.992637, 12.098951),
        infoWindow: InfoWindow(title: ('Unisport'))));
  }

  void _getPoints() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Gratulation!'),
              content: Text('100 Punkte ersportlt'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              backgroundColor: barColor,
              contentTextStyle: TextStyle(color: bgColor, fontSize: 22),
              titleTextStyle: TextStyle(color: bgColor, fontSize: 33));
        });
  }

  void checkLocationMarker(LatLng l) {
    LatLng markersLocation = LatLng(48.992637, 12.098951);
    if (l.latitude >= (markersLocation.latitude - 0.0002) &&
        l.latitude <= (markersLocation.latitude + 0.0002)) {
      _getPoints();
    }
  }

  void _onMapCreated(GoogleMapController _cntrl) {
    _controller = _cntrl;
    var location = _location.getLocation();
    _location.onLocationChanged().listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 14),
        ),
      );
      checkLocationMarker(LatLng(l.latitude, l.longitude));
    });
  }

  
  Widget build(context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Workout'),
        backgroundColor: barColor,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set.from(allMarkers),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            // getCurrentLocation();
          }),
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