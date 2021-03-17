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

import 'saveRun.dart';
import 'package:background_location/background_location.dart' as lib3;

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
  bool inPacelimit = true;
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

 
  LocationData currentLocation;
  double _loc = 0;
  int sport = 1;

  int points = 0;
  double maxSpeed = 0;
  void startTimer() {
    Timer(dur, keeprunning);
  }

  String lib3latitude = "waiting...";
  String lib3longitude = "waiting...";
  String lib3altitude = "waiting...";
  String lib3accuracy = "waiting...";
  String lib3bearing = "waiting...";
  String lib3speed = "waiting...";
  String lib3time = "waiting...";



  void keeprunning() {
    print('Timer time: $sec');
    if (_stopwatch.isRunning) {
      startTimer();
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
        
      });
      
    } else
      stopstopwatch();
  }

// Get first locaiton for correct distance calculation
Future <void> firstlocation() async{
    var loc = await _location.getLocation();
    setState(() {
      latlngend = lib2.LatLng(loc.latitude, loc.longitude);
    });

}


  void startstopwatch() async {
      
      await firstlocation();
      

      
     
       await lib3.BackgroundLocation.setAndroidNotification(
            
                        title: "Background service is running",
                        message: "Background location in progress",
                        icon: "@mipmap/ic_launcher",
                    ); 

   
            
            await lib3.BackgroundLocation.startLocationService(distanceFilter: 0);
                    lib3.BackgroundLocation.getLocationUpdates((location) {

                      
                      setState(() {
                        
                        this.lib3latitude = location.latitude.toString();
                        this.lib3longitude = location.longitude.toString();
                        this.lib3accuracy = location.accuracy.toString();
                        this.lib3altitude = location.altitude.toString();
                        this.lib3bearing = location.bearing.toString();
                        this.lib3speed = location.speed.toString();
                        this.lib3time = DateTime.fromMillisecondsSinceEpoch(
                                location.time.toInt())
                            .toString();
                     
                      _loc = double.parse(lib3altitude);
                      print('Location Altitude: '+ _loc.toString());
                      linehlp = LatLng(double.parse(lib3latitude), double.parse(lib3longitude));
                     
                      latlngstart = lib2.LatLng(double.parse(lib3latitude), double.parse(lib3longitude));
                      
                      distancemeter += distance(latlngstart, latlngend);
                      
                      latlngend = latlngstart;
      
                      });
                     
                    });
    setState(() {
      timerisrunning = true;
      showRun = true;
    });
    _stopwatch.start();
    startTimer();
  }

  void stopstopwatch() {
    lib3.BackgroundLocation.stopLocationService();
    setState(() {
      timerisrunning = false;
      showRun = false;
    });
    _stopwatch.stop();
  }

  int addPoints(int distancelocal) {
   
    int pointlocal = distancelocal ~/ 100;
    return pointlocal;
  }

// Calculator: Meter/second to km/h
void ms2kmh(double speedMeter){
  setState(() {
    maxSpeed = speedMeter * 3.6;
  });
}

//Algorithmus gegen Schummeln: Max. Geschwindigkeit, darf nicht größer als speed[km/h] sein (aktuell Usain Bolt max Pace))
void checkPace(double speed){
  print('Max. Geschwindigkeit: $maxSpeed');
  if(speed>38){
    setState(() {
    inPacelimit = false;
  });
  }
}

  void endrun(BuildContext context, bool inPacelimit) {

    if (inPacelimit == true) {
      points = addPoints(dis);}
    latlnglines = [];
    ms2kmh(maxSpeed);
    print('Running.dart: Altitdue Länge: ' + altitude.length.toString());

    print('Running.dart: List<double> altitude: ' + altitude.toString());
    if(dis != 0){
      
      
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
    else 
    {
      showNoMovement(context);
     
    }
    
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

      
     });
  }

  //AlertDialog, if User is to Fast
  Future<void> toFast() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Zu schnell unterwegs'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      
                      Text('Mit deinem Tempo warst du schneller unterwegs als der Weltmeister im 100-Meter-Sprint Usain Bolt - wir gehen davon aus, dass du geschummelt hast; daher werden deine erreichten Punkte nicht gewertet.'),

                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      setState(() {
                        points = 0;
                      });
                      endrun(context, false);


                      
                    },
                  ),
                ],
              );
            },
          );
        }

        
// Start/Stop Buttons: startsopwatch(), checkPace(), endrun(), toFast(), stopstopwatch()
  Widget _getFAB(BuildContext context) {
    if (showRun == false) {
      return Row(
        children: [
          RawMaterialButton(
            onPressed: () {
            
                    startstopwatch();
              
            },

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
            onPressed: ()async{
              
              checkPace(maxSpeed*3.6);
              
              if(inPacelimit){endrun(context, true);}
              else{
                await toFast();
              }
              
              },
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
              child: _getFAB(context),
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

showNoMovement(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
       Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Running()),
                );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Keine Strecke gelaufen"),
    content: Text("Du hast keinen Meter zurückgelegt. Lege eine Strecke zurück, bevor du deinen Lauf beendest."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return alert;
    },
  );
}

