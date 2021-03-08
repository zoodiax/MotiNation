import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lib2;
import 'package:location/location.dart';
//import 'package:motination/src/authentication/sign_in.dart';

import 'saveRun.dart';
import '../../../widgets/bottomBar.dart';

import 'package:motination/shared/constants.dart';

import 'package:motination/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motination/src/authentication/signIn.dart';

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

  bool showRun = true;
  bool showSportType = false;
  final AuthService _auth = AuthService();
  LatLng linehlp = LatLng(0, 0);
  int _currentIndex = 1;
  Icon _iconSport = Icon(Icons.directions_run);
  //polylines:
  final Set<Polyline> _polyline = {};
  List<LatLng> latlnglines = List();
  List<LatLng> latlnglines2 = List();
  List<double> altitude = List();
  List<double> altitude2 = List();
 
  LocationData currentLocation;
  double _loc = 1;
  int sport = 1;

  int points = 0;
  double maxSpeed = 0;
  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (_stopwatch.isRunning) {
      startTimer();
      latlngstart = latlnghlp;
      distancemeter += distanceBetween(latlngstart, latlngend);
      latlngend = latlngstart;
      latlnglines.add(linehlp);
      altitude.add(_loc);
      _location.onLocationChanged().listen((event) {
        setState(() {
        currentLocation = event;
        maxSpeed < event.speed ? maxSpeed = event.speed: maxSpeed = maxSpeed; 
       
      });
      });
      
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

  int addPoints(int distancelocal) {
    int pointlocal = distancelocal ~/ 1000;
    return pointlocal;
  }

void ms2kmh(double speedMeter){
  setState(() {
    maxSpeed = speedMeter * 3.6;
  });
}
  void endrun() {
    points = addPoints(dis);
    latlnglines = [];
    ms2kmh(maxSpeed);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SaveRun(
                dis: dis,
                time: time,
                kcal: kcal,
                latlng: latlnglines2,
                altitude: altitude,
                sport: sport,
                points: points,
                tempo: tempodisplay,
                maxspeed: maxSpeed,
              )),
    );
  }

  double distanceBetween(lib2.LatLng start, lib2.LatLng end) {
    double dis = 0;
    dis = distance(start, end);

    return dis;
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
      // setState(() {
      //   currentLocation = l;
       
      // });
      // print('Speed:' + currentLocation.speed.toString());

      // _controller.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16)));
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
              _iconSport = Icon(Icons.directions_run);
              if (val == 1) {
                print("run selectet");
                sport = 1;
              } else if (val == 2) {
                print("bike selectet");
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
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "Cycling",
                style: Theme.of(context).textTheme.bodyText2,
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
            title: Text('Motination ',
                style: GoogleFonts.spartan(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
            backgroundColor: bgColor,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: blue,
                ),
                label: Text(
                  'Logout',
                  style: GoogleFonts.spartan(
                      textStyle: TextStyle(color: Colors.black)),
                ),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
              )
            ],
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: bgColor,
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'ø  Min/km',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
          bottomNavigationBar: bottomBar(_currentIndex, context),
        ));
  }
}
