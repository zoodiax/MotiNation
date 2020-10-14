import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lib2;
import 'package:location/location.dart';
import 'package:motination/src/UI/challenge.dart';

import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';



/* Running Class UI Design
  Content: Start/ Stop Button, Center Position Button, Bottom Navigation Bar, Stopwatch, Distance, Speed, Time, Google Maps
  Function: startTimer, keeprunning, startstopwatch, stopstopwatch, distanceBetween, onMapCreated
             MaterialPageRoute -> (Running, Workout, Profile, Challenge, Shop) 
*/

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
  String distancedisplay = '0.00 ';
  String caldisplay = '0';
  String tempodisplay = '0 ';
  int min = 0;
  int sec = 0;
  int weigth = 70;
  int met = 12;
  final Duration dur = const Duration(seconds: 1);
  final lib2.Distance distance = new lib2.Distance();
  double distancemeter =0;
  lib2.LatLng latlngstart = lib2.LatLng(49.012260, 12.096680);
  lib2.LatLng latlngend = lib2.LatLng(49.015982, 12.107087);
  lib2.LatLng latlnghlp = lib2.LatLng(0, 0);

  LatLng linehlp = LatLng(0,0);
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  //polylines: 
  final Set<Polyline> _polyline = {};
  List<LatLng> latlnglines = List();
  // LatLng _lineone = LatLng(49.016144,12.093372);
  // LatLng _linetwo = LatLng(49.017270,12.100067);
  // LatLng _linethree = LatLng(49.020366,12.090564);
  // LatLng _linefour = LatLng(49.021041,12.084552);
  



  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (_stopwatch.isRunning) {
      startTimer();
      latlngstart = latlnghlp;
      distanceBetween(latlngstart, latlngend);
      latlngend = latlngstart;
      latlnglines.add(linehlp);
      
      // latlnglines.add(_lineone);
      // latlnglines.add(_linetwo);
      // latlnglines.add(_linethree);
      // latlnglines.add(_linefour);
      setState(() {
        timerdisplay = (_stopwatch.elapsed.inHours.toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0'));
        
        min = (_stopwatch.elapsed.inSeconds / (60 * distancemeter/1000)).toInt() ;              
        sec = ((((_stopwatch.elapsed.inSeconds / (60 * distancemeter/1000))*100).toInt() - min*100) * 0.6).toInt();
        caldisplay = (_stopwatch.elapsed.inSeconds / 60 * 3.5 * weigth * met/200).toInt().toString();
        tempodisplay = min.toString() + ':' + sec.toString().padLeft(2, '0');
        distancedisplay = ((distancemeter/1000).toStringAsFixed(2));
      
      _polyline.add(Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: latlnglines,
        color: Colors.blue,
        width: 4,
      ));
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
    latlnglines = [];
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
      linehlp = LatLng(hlplat, hlplng);

      
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
                                  child: Text('Distanz km', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
                                  child: Text(caldisplay, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text('Kalorien kcal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
                                  child: Text(tempodisplay, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text('ø Tempo /km', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
                zoom: 11,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              onMapCreated: _onMapCreated,
              polylines: _polyline,
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
          });
        },
      ),
    );
  }
}
