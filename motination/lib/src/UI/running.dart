import 'dart:async';
import 'package:latlong/latlong.dart' as lib2;
import 'package:flutter/material.dart';
import 'shop.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Running extends StatefulWidget {
  @override
  createState() {
    return RunningState();
  }
}

class RunningState extends State<Running> {
  LatLng _initialPosition = LatLng(49.017214, 12.097498);
  GoogleMapController _controller;
  Location _location = Location();
  bool timerisrunning = false;
  Stopwatch _stopwatch = Stopwatch();
  String timerdisplay = '00:00:00';
  String distancedisplay = '0.00 km';
  String speeddisplay = '0 km/h';
  String minkmdisplay = '0 min / km';
  final Duration dur = const Duration(seconds: 1);
  final lib2.Distance distance = new lib2.Distance();
  double distancemeter =0;
  lib2.LatLng latlngstart = lib2.LatLng(49.012260, 12.096680);
  lib2.LatLng latlngend = lib2.LatLng(49.015982, 12.107087);
  lib2.LatLng latlnghlp = lib2.LatLng(0, 0);

  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (_stopwatch.isRunning) {
      startTimer();
      latlngstart = latlnghlp;
      distanceBetween(latlngstart, latlngend);
      latlngend = latlngstart;
      setState(() {
        timerdisplay = (_stopwatch.elapsed.inHours.toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0'));
        speeddisplay = (distancemeter * 3.6 / _stopwatch.elapsed.inSeconds).toStringAsFixed(2) + ' km/h';
        minkmdisplay = ((_stopwatch.elapsed.inSeconds * 1000) / (distancemeter * 60)).toStringAsFixed(2)  +
                       // ((_stopwatch.elapsed.inSeconds *1000 /distancemeter)%60).toStringAsFixed(2) + 
                        ' min/km';
        
      distancedisplay = ((distancemeter/1000).toStringAsFixed(2) + ' km');
      });
    } else
      stopstopwatch();
  }

  void startstopwatch() {
    setState(() {
      timerisrunning = true;
    });
    latlngstart = latlnghlp;
    latlngend = latlnghlp;
    _stopwatch.start();
    startTimer();
  }

  void stopstopwatch() {
    setState(() {
      timerisrunning = false;
    });
    _stopwatch.stop();
  }

void distanceBetween(lib2.LatLng start, lib2.LatLng end){
    double hlp = 0;
    hlp = distance(start, end);
    distancemeter += hlp;
    // setState(() {
    //   distancedisplay = ((distancemeter/1000).toStringAsFixed(2) + ' km');
    // });
  }



  void _onMapCreated(GoogleMapController _cntrl) {
    _controller = _cntrl;
    _location.getLocation();
    _location.onLocationChanged().listen((l) {
      double hlplat = l.latitude;
      double hlplng = l.longitude;
      latlnghlp = lib2.LatLng(hlplat, hlplng);
     
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 14)));
    });
  }

  Widget build(context) {
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Running'),
        backgroundColor: barColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              color: bgColor,
              child: Column(children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    color: bgColor,
                    alignment: Alignment.center,
                    child: Text(timerdisplay,
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: bgColor,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.center,
                                  child: Text(distancedisplay, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text('Distanz', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                ),
                              ),
                            ]),
                          ),
                          Expanded(
                            child: Column(children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.center,
                                  child: Text(speeddisplay, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text('Geschwindigkeit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                ),
                              ),
                            ]),
                          ),
                          Expanded(
                            child: Column(children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.center,
                                  child: Text(minkmdisplay, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text('Zeit', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    )),
              ]),
            ),
          ),
          Expanded(
            flex: 5,
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 13,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              onMapCreated: _onMapCreated,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (timerisrunning == true) ? stopstopwatch : startstopwatch,
        child: (timerisrunning == true)
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            if (_currentIndex == 0)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            if (_currentIndex == 1)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            if (_currentIndex == 2)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shoping()),
              );
          });
        },
      ),
    );
  }
}
