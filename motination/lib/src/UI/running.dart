import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lib2;
import 'package:location/location.dart';

import 'workout.dart';
import 'workoutInfo.dart';

import 'profile.dart';
import 'shop.dart';
import 'saveRun.dart';

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
  int dis = 0;
  int kcal = 0;
  int min = 0;
  int sec = 0;
  int weight = 70;
  int time = 0;
  final Duration dur = const Duration(seconds: 1);
  final lib2.Distance distance = new lib2.Distance();
  double distancemeter = 0;
  lib2.LatLng latlngstart = lib2.LatLng(49.012260, 12.096680);
  lib2.LatLng latlngend = lib2.LatLng(49.015982, 12.107087);
  lib2.LatLng latlnghlp = lib2.LatLng(0, 0);
  final blue = const Color(0xff191970);
  final pink = const Color(0xFFc71585);
  bool showRun = true;
  bool showSportType = false;

  LatLng linehlp = LatLng(0, 0);
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  //polylines:
  final Set<Polyline> _polyline = {};
  List<LatLng> latlnglines = List();
  List<LatLng> latlnglines2 = List();
  List<double> altitude = List();
  List<double> altitude2 = List();
  List<double> altitude3 = [1];
  double _loc = 1;
  int sport = 1;
  Icon _iconSport = Icon(Icons.directions_run);

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
      altitude.add(_loc);

      setState(() {
        timerdisplay = (_stopwatch.elapsed.inHours.toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')) +
            ':' +
            ((_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0'));

        min = _stopwatch.elapsed.inSeconds ~/ (60 * distancemeter / 1000);
        sec = ((((_stopwatch.elapsed.inSeconds / (60 * distancemeter / 1000)) *
                            100)
                        .toInt() -
                    min * 100) *
                0.6)
            .toInt();
        kcal = weight * distancemeter ~/ 1000;
        time = _stopwatch.elapsed.inSeconds;
        dis = distancemeter.toInt();
        caldisplay = kcal.toString();
        tempodisplay = min.toString() + ':' + sec.toString().padLeft(2, '0');
        distancedisplay = ((distancemeter / 1000).toStringAsFixed(2));

        _polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: latlnglines,
          color: blue,
          width: 4,
        ));
        latlnglines2.add(linehlp);
        altitude2.add(_loc);
      });
    } else
      stopstopwatch();
  }

  void startstopwatch() {
    setState(() {
      timerisrunning = true;
      showRun = true;
    });
    latlngstart = latlnghlp;
    latlngend = latlnghlp;
    _stopwatch.start();
    startTimer();
  }

  void stopstopwatch() {
    setState(() {
      timerisrunning = false;
      showRun = false;
    });
    _stopwatch.stop();
  }

  void endrun() {
    latlnglines = [];
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SaveRun(
              dis: dis,
              time: time,
              kcal: kcal,
              latlng: latlnglines2,
              altitude: altitude,
              sport: sport)),
    );
  }




  void distanceBetween(lib2.LatLng start, lib2.LatLng end) {
    double hlp = 0;
    hlp = distance(start, end);
    distancemeter += hlp;
  }






  void _onMapCreated(GoogleMapController _cntrl) {
    _controller = _cntrl;
   
    _location.getLocation();
    _location.onLocationChanged().listen((l) {
      _loc = l.altitude;
      double hlplat = l.latitude;
      double hlplng = l.longitude;
      latlnghlp = lib2.LatLng(hlplat, hlplng);
      linehlp = LatLng(hlplat, hlplng);

      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16)));
    });
  }

  Widget _getFAB() {
    if (showRun == false) {
      return Row(
        children: [
          RawMaterialButton(
            onPressed: startstopwatch,
            elevation: 2.0,
            fillColor: blue,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 35,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: endrun,
            elevation: 2.0,
            fillColor: blue,
            child: Icon(
              Icons.stop,
              color: Colors.white,
              size: 35.0,
            ),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      );
      


    } else {
      return RawMaterialButton(
        onPressed: (timerisrunning == true) ? stopstopwatch : startstopwatch,
        child: (timerisrunning == true)
            ? Icon(
                Icons.pause,
                size: 35,
                color: Colors.white,
              )
            : Icon(
                Icons.play_arrow,
                size: 35,
                color: Colors.white,
              ),
        elevation: 2.0,
        fillColor: blue,
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      );
    }
  }

// Filter Button, different sport disciplines
  Widget _sportType() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          shape: BoxShape.circle,
          color: bgColor,
        ),
        child: PopupMenuButton<int>(
          onSelected: (val) {
            setState(() {
              if (val == 1) {
                sport = 1;
                _iconSport = Icon(Icons.directions_run);
              } else if (val == 2) {
                sport = 2;
                _iconSport = Icon(Icons.directions_bike);
              } else {
                _iconSport = Icon(Icons.cached);
              }
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                "Running",
                style:
                    Theme.of(context).textTheme.bodyText2,
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "Cycling",
                style:
                     Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
          icon: _iconSport,
          offset: Offset(0, -120),
        ));
  }

  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Running' , style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,
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
                            style: Theme.of(context).textTheme.headline3),
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
                                      child: Text(
                                        distancedisplay,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: bgColor,
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Distanz km',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
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
                                      child: Text(
                                        caldisplay,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: bgColor,
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Kalorien kcal',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
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
                                      child: Text(
                                        tempodisplay,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: bgColor,
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'ø Tempo /km',
                                        style: Theme.of(context).textTheme.bodyText2,
                                      ),
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
                    zoom: 16,
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
          floatingActionButton: //_getFAB(),
              Stack(children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: _getFAB(),
            ),
            Align(
              alignment: Alignment(-0.95, 1),
              child: _sportType(),
            ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: blue,
            backgroundColor: bgColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer, color: blue,),
                title: Text('Running', style: TextStyle(color: blue),),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                title: Text('Workout'),
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
                    MaterialPageRoute(builder: (context) => Running()),
                  );
                if (_currentIndex == 3)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Shoping()),
                  );
                if (_currentIndex == 2)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutInfo()),
                  );
              });
            },
          ),
        ));
  }
}
