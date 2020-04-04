import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:location/location.dart';
import 'dart:async';

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
  bool _alreadyWorkout = false;
  int _currentIndex = 2;

  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final black = const Color(0xFF000000);

void _marker1tap(){ (showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('das Stadtwerk.Hallenbad'),
                  content: Text(
                      'Kategorie:   Hallenschwimmbad  Addresse:   Gabelsbergerstr. 14 Telefon:       0941 6012977 '),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  backgroundColor: bgColor,
                  contentTextStyle: TextStyle(color: black, fontSize: 18),
                  titleTextStyle: TextStyle(color: barColor, fontSize: 25));
            }));}
  
  void _marker2tap(){(showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Unisport Regensburg'),
                  content: Text(
                      'Kategorie:   Universitätssport  Addresse:   Am Biopark 12      Telefon:       0941 9432507 '),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  backgroundColor: bgColor,
                  contentTextStyle: TextStyle(color: black, fontSize: 18),
                  titleTextStyle: TextStyle(color: barColor, fontSize: 25));
            }));}

  void _marker3tap(){(showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text('Fitness First'),
                  content: Text(
                      'Kategorie:   Fitnessstudio  Addresse:   Bahnhofstr. 12    Telefon:       0941 584070 '),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  backgroundColor: bgColor,
                  contentTextStyle: TextStyle(color: black, fontSize: 18),
                  titleTextStyle: TextStyle(color: barColor, fontSize: 25));
            }));}


  @override
  void initState() {
    super.initState();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker1'),
      draggable: false,
      position: LatLng(49.015982, 12.107087),
      infoWindow: InfoWindow(title: ('das Stadtwerk.Hallenbad')),
      onTap: () {
        _marker1tap();
      },
    ));

    allMarkers.add(Marker(
      markerId: MarkerId('myMarker2'),
      draggable: false,
      position: LatLng(48.992637, 12.098951),
      infoWindow: InfoWindow(title: ('Unisport Regensburg')),
      onTap: () {
        _marker2tap();
      },
    ));

    allMarkers.add(Marker(
      markerId: MarkerId('myMarker3'),
      draggable: false,
      position: LatLng(49.012260, 12.096680),
      infoWindow: InfoWindow(
        title: ('Fitness First'),
      ),
      onTap: () {
        _marker3tap();
      },
    ));
  }

  void _info() {}
  void _getPoints() {
    if (_alreadyWorkout == true)
      return;
    else {
      (showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('Gratulation!'),
                content: Text('100 Punkte ersportlt'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                backgroundColor: bgColor,
                contentTextStyle: TextStyle(color: black, fontSize: 18),
                titleTextStyle: TextStyle(color: barColor, fontSize: 25));
          }));
      _alreadyWorkout = true;
    }
  }

  void checkLocationMarker(LatLng l) {
    LatLng markersLocation;
    int i = 0;
    while (allMarkers[i] != null) {
      markersLocation = allMarkers[i].position;
      if (l.longitude >= (markersLocation.longitude - 0.0005) &&
          l.longitude <= (markersLocation.longitude + 0.0005) &&
          l.latitude >= (markersLocation.latitude - 0.0005) &&
          l.latitude <= (markersLocation.latitude + 0.0005)) {
        _getPoints();
      }
      i++;
    }
  }

  void _onMapCreated(GoogleMapController _cntrl) {
    _controller = _cntrl;
    var location = _location.getLocation();

    _location.onLocationChanged().listen((l) {
      checkLocationMarker(LatLng(l.latitude, l.longitude));
    });
  }

  Widget build(context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Workout'),
                //backgroundColor: barColor,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.map)),
                    Tab(icon: Icon(Icons.settings)),
                    Tab(icon: Icon(Icons.list)),
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14,
                    ),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    scrollGesturesEnabled: true,
                    onMapCreated: _onMapCreated,
                    markers: Set.from(allMarkers),
                  ),
                  Icon(Icons.settings),
                  ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.pool),
                        title: Text('das Stadtwerk.Hallenbad'),
                        onTap: () {_marker1tap();}

                      ),
                      ListTile(
                        leading: Icon(Icons.fitness_center),
                        title: Text('Unisport Regensburg'),
                        onTap: () {_marker2tap();}
                      ),
                      ListTile(
                        leading: Icon(Icons.fitness_center),
                        title: Text('Fitness First'),
                        onTap: () {_marker3tap();}
                      ),
                    ]
                  )
                  
                ],
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
            )));
  }
}
