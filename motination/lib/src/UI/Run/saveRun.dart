import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../services/database.dart';

import 'package:motination/services/database.dart';

import 'package:motination/models/user.dart';

import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:motination/shared/constants.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'running.dart';
import 'package:motination/widgets/gridItem.dart';

class SaveRun extends StatefulWidget {
  final int dis;
  final int kcal;
  final int time;
  final List<LatLng> latlng;
  final Set<Polyline> polyline;
  final List<double> altitude;
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
  double altitudeUp = 0, altitudeDown = 0;
  String _sumdis, _sumtime, _sumspeed;

  //String _currenttime, _currentspeed, _currentdistance;

  //List<double> testAlt = [-1, 7, 3, -1, 3];
  void buildPolyline(List<LatLng> list) {
    _polyline.add(Polyline(
      polylineId: PolylineId('route1'),
      visible: true,
      points: list,
      color: blue,
      width: 4,
    ));
  }

  Future <void> getData(User user) async{
    try{
      DocumentSnapshot snapshot = await DatabaseService(uid: user.uid).getUserData();
    Map<String, dynamic> data = snapshot.data;
    setState(() {
    
    _sumdis = data["sumdistanz"]?? "0";
    // _sumspeed = data["sumspeed"]?? "0";
    // _sumtime = data["sumtime"]?? "0";
    print('getdata finished');
    }); 
    
    }
    catch(err){
    print(err.toString());
    }
  }

  void changeSumData(int distance){
    int dis = int.parse(_sumdis) + distance;
    
    setState(() {
      _sumdis = dis.toString();
    });
    print('sumdis = $_sumdis');
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

  void sumUpdate(int dis, int time){

  }

  // Höhenmeter berechen; Übergabe: List<double> list, setState double altitude
  void calcAlt(List<double> alt) {
    double altref = alt[0];
    double altListUp = 0;
    double altListDown = 0;
    double altdiff = 0;
    for (int i = 0; i < alt.length; i++) {
      altdiff = alt[i] - altref;
      if (altdiff >= 0) {
        altListUp += altdiff;
      } else {
        altListDown += altdiff.abs();
      }

      altref = alt[i];
    }
    setState(() {
      altitudeUp = altListUp;
      altitudeDown = altListDown;
    });
    print('alt Up:' + altListUp.toString());
    print('alt Down: ' + altListDown.toString());
  }

  // void getDatafromSnapshot(DocumentSnapshot snapshot) {
  //   Map<String, dynamic> data = snapshot.data;

  //   setState(() {
  //     _currentspeed = data['groese']; //data['sumspeed'];
  //     _currenttime = data['groese']; //data['sumtime'];
  //     _currentdistance = data['groese']; //data['sumdistanz'];
  //   });
  // }

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
      return FlatButton.icon(
        icon: Icon(
          Icons.directions_run,
          color: blue,
        ),
        label: Text(''),
        // label: Text(
        //   'Lauf',
        //   style: Theme.of(context).textTheme.bodyText2,
        // ),
        onPressed: null,
      );
    } else
      return FlatButton.icon(
        icon: Icon(
          Icons.directions_bike,
          color: blue,
        ),
        label: Text(''),
        // label: Text(
        //   'Logout',
        //   style: Theme.of(context).textTheme.bodyText2,
        // ),
        onPressed: null,
      );
  }

  FloatingActionButton saveRun(User user) {
    return FloatingActionButton(
      onPressed: () async {
        // DocumentSnapshot doc =
        //     await DatabaseService(uid: user.uid).getData(user);
        // getDatafromSnapshot(doc);
        await getData(user);
         
        changeSumData(widget.dis);
         

        await DatabaseService(uid: user.uid).updateSumDistance(_sumdis);
         
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
            altitudeUp,
            altitudeDown);
        
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
    //calcAlt(testAlt);

    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              Text('Geschafft!', style: Theme.of(context).textTheme.headline1),
          backgroundColor: bgColor,
          actions: <Widget>[
            _sportType(),
          ]),
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
                            gridItem(
                                Icons.alt_route,
                                Colors.black87,
                                (widget.dis / 1000).toStringAsFixed(2),
                                'Distanz [Km]',
                                context),
                            gridItem(
                                Icons.timer,
                                blue,
                                showTime(widget.time),
                                'Zeit [Min]',
                                context),
                            gridItem(
                                Icons.local_fire_department_sharp,
                                Colors.orange,
                                widget.kcal.toString(),
                                'Kalorien',
                                context),
                            gridItem(
                               MaterialIcons.monetization_on,
                               Colors.yellow,
                                widget.points.toString(),
                                'Punkte',
                                context),
                            gridItem(
                                Icons.trending_up_rounded,
                                 Colors.green[500],
                                altitudeUp.toString(),
                                'Höhenmeter[m]',
                                context),
                            gridItem(
                                Icons.trending_down_rounded,
                                Colors.red[500],
                                altitudeDown.toString(),
                                'Tiefenmeter[m]',
                                context),
                                  
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
    );
  }
}
