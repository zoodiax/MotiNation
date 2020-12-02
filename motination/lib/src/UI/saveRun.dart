import 'package:flutter/material.dart';

import 'package:motination/src/UI/challenge.dart';

import '../../services/database.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';

import 'package:motination/services/database.dart';

import 'package:motination/models/user.dart';

import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:motination/shared/constants.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'running.dart';
import 'package:motination/shared/theme.dart';

class SaveRun extends StatefulWidget {
  final int dis;
  final int kcal;
  final int time;
  List<LatLng> latlng;
  final Set<Polyline> polyline;
  List<double> altitude;
  final int sport;
  final int points;

  SaveRun(
      {Key key,
      this.dis,
      this.kcal,
      this.time,
      this.latlng,
      this.polyline,
      this.altitude,
      this.sport,
      this.points})
      : super(key: key);
  @override
  _SaveRunState createState() => new _SaveRunState();
}

class _SaveRunState extends State<SaveRun> {
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  LatLng _initialPosition = LatLng(37.3318095, -122.030598);
  final Set<Polyline> _polyline = {};
  final List<double> lat = [];
  final List<double> lng = [];
  final List<double> alt = [];
  String date;
  String sportType;
  double latmin, latmax, lngmin, lngmax, latinit, lnginit;
  double altitude = 0;
  String _currenttime, _currentspeed, _currentdistance;

  void buildPolyline(List<LatLng> list) {
    _polyline.add(Polyline(
      polylineId: PolylineId('route1'),
      visible: true,
      points: list,
      color: blue,
      width: 4,
    ));
  }

  void data2collection(List<LatLng> list, List<double> altitude) {
    latmin = list[0].latitude;
    lngmin = list[0].longitude;
    latmax = list[0].latitude;
    lngmax = list[0].longitude;

    for (int i = 0; i < list.length; i++) {
      lat.add(list[i].latitude);
      lng.add(list[i].longitude);
      latlngmax(list[i].latitude, list[i].longitude);
    }
    for (int i = 0; i < altitude.length; i++) {
      alt.add(altitude[i]);
    }
  }

  void latlngmax(double lat, double lng) {
    if (latmin > lat) {
      latmin = lat;
    }
    if (latmax < lat) {
      latmax = lat;
    }
    if (lngmin > lng) {
      lngmin = lng;
    }
    if (lngmax < lng) {
      lngmax = lng;
    }
  }

  void initposition() {
    lnginit = (lngmax + lngmin) / 2;
    latinit = (latmax + latmin) / 2;
    setState(() {
      _initialPosition = LatLng(latinit, lnginit);
    });
  }

  void getDate() {
    setState(() {
      date = DateTime.now().toString();
    });
  }

  void getSport() {
    if (widget.sport == 1) {
      sportType = 'running';
    } else if (widget.sport == 2) {
      sportType = 'bike';
    } else
      sportType = null;
  }

  // Höhenmeter berechen; Übergabe: List<double> list, setState double altitude
  void calcAlt(List<double> alt) {
    double altList = 0;
    for (final e in alt) {
      altList += e;
    }
    setState(() {
      altitude = altList;
    });
  }

  void getDatafromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;

    setState(() {
      _currentspeed = data['groese']; //data['sumspeed'];
      _currenttime = data['groese']; //data['sumtime'];
      _currentdistance = data['groese']; //data['sumdistanz'];
    });
  }

  String showTime(int second) {
    int s = second;
    return (Duration(seconds: s).inHours.toString().padLeft(2, '0') +
        ':' +
        (Duration(seconds: s).inMinutes % 60).toString().padLeft(2, '0') +
        ':' +
        (Duration(seconds: s).inSeconds % 60).toString().padLeft(2, '0'));
  }

  Widget _sportType() {
    if (sportType == 'running') {
      return Column(
        children: <Widget>[
          Icon(
            Icons.directions_run,
            color: Colors.red[500],
            size: 70,
          ),
          Spacer(),
          Text('Joggen', style: Theme.of(context).textTheme.bodyText1),
          Text(
            'Sportart',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      );
    } else
      return Column(
        children: <Widget>[
          Icon(
            Icons.directions_bike,
            color: Colors.red[500],
            size: 70,
          ),
          Spacer(),
          Text('Radln', style: Theme.of(context).textTheme.bodyText1),
          Text(
            'Sportart',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      );
  }

  FloatingActionButton saveRun(User user) {
    return FloatingActionButton(
      onPressed: () async {
        DocumentSnapshot doc =
            await DatabaseService(uid: user.uid).getData(user);
        getDatafromSnapshot(doc);

        await DatabaseService(uid: user.uid).updateRunData(
            widget.dis.toString(),
            widget.kcal.toString(),
            widget.time.toString(),
            lat,
            lng,
            latinit,
            lnginit,
            date,
            sportType,
            widget.points,
            altitude);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Running()),
        );
      },
      child: Icon(Icons.save),
      backgroundColor: blue,
    );
  }

  Widget build(context) {
    User user = Provider.of<User>(context);
    buildPolyline(widget.latlng);
    data2collection(widget.latlng, widget.altitude);
    initposition();
    getDate();
    getSport();
    calcAlt(widget.altitude);

    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Geschafft!', style: Theme.of(context).textTheme.headline1),
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 1100),
          child: Container(
            alignment: Alignment.center,
            child: Column(children: <Widget>[
              Expanded(
                flex: 1,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 16,
                  ),
                  myLocationButtonEnabled: false,

                  //myLocationEnabled: true,
                  scrollGesturesEnabled: true,
                  //onMapCreated: _onMapCreated,
                  polylines: _polyline,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Text(''),
                      Text('Gratulation!',
                          style: Theme.of(context).textTheme.bodyText1),
                      Text(' Hier deine Ergebnisse:',
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        //flex: 5,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 15,
                          padding: const EdgeInsets.all(20),
                          children: <Widget>[
                            //Distanz Feld
                            Center(
                              child: Container(
                                height: 200,
                                width: 175,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.alt_route,
                                      color: Colors.black87,
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text((widget.dis / 1000).toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text('Distanz [Km]',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ),
                            ),
                            // Zeit Feld
                            Center(
                              child: Container(
                                height: 200,
                                width: 175,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: mainColor,
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text(showTime(widget.time),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      'Zeit [Min]',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Center(
                              child: Container(
                                height: 200,
                                width: 175,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_fire_department_sharp,
                                      color: Colors.orange,
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text(widget.kcal.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      'Kalorien',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Punkte Feld
                            Center(
                              child: Container(
                                width: 175,
                                height: 200,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      MaterialIcons.monetization_on,
                                      color: Colors.yellow,
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text(widget.points.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      'Punkte',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Höhenmeter Feld
                            Center(
                              child: Container(
                                width: 175,
                                height: 200,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.trending_up_rounded,
                                      color: Colors.green[500],
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text(altitude.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(
                                      'Altitude [m]',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Feld Sportart
                            Center(
                              child: Container(
                                width: 175,
                                height: 200,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: _sportType(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        ),
      ),
      floatingActionButton: saveRun(user),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: bgColor,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text('Profile'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.directions_run),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.fitness_center),
      //       title: Text('Workout'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_basket),
      //       title: Text('Shop'),
      //     ),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //       if (_currentIndex == 0)
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Profile()),
      //         );
      //       if (_currentIndex == 1)
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Running()),
      //         );
      //       if (_currentIndex == 3)
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Shoping()),
      //         );
      //       if (_currentIndex == 2)
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => Challenge()),
      //         );
      //     });
      //   },
      // ),
    );
  }
}
