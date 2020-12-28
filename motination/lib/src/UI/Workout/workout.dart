import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:motination/shared/constants.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:motination/src/UI/Workout/workoutInfo.dart';



import 'package:motination/models/markerz.dart';


import '../../../models/spzinfo.dart';

import '../../../widgets/bottomBar.dart';
import 'package:motination/services/auth.dart';
/* Workout Class UI Design & Logic
  Content: List View Column, MapView Column, Floarting Action Button (Filter Function), Center Location, Categroy class(Filter),
          List Categories, class Markerz, List Markerz
  Function:  onMapCreated
             MaterialPageRoute -> (Home, Profile, Challenge, Shop) 
*/

class Workout extends StatefulWidget {
  createState() {
    return WorkoutState();
  }
}

class WorkoutState extends State<Workout> {
  LatLng _initialPosition = LatLng(49.017214, 12.097498);
  Location _location = Location();
  bool _alreadyWorkout = false;
  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final black = const Color(0xFF000000);
  final AuthService _auth = AuthService();


  void initState() {
    super.initState();
    setState(() {
      fillMarker();
    });
  }

// Liste mit allen Marker - wird in initState gefüllt
List<Markerz> allMarkers = [];

// Firebase Verbindung aufbauen mit Sportzentren spz für Marker
  fillMarker() {
    Firestore.instance.collection('spz').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; ++i) {
          initMarker(docs.documents[i].data);
        }
      }
    });
  }

// Marker-Initalisieren
  initMarker(marker) {
    setState(() {
      allMarkers.add(Markerz(
        markerId: MarkerId(marker['spzId']),
        position:
            LatLng(double.parse(marker['lat']), double.parse(marker['lng'])),
        infoWindow: InfoWindow(title: marker['name']),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SpzInfo(
                      infocategory: marker['category'] ?? 'Musterkategorie',
                      infotitle: marker['name'] ?? 'Muster Sportzentrum',
                      infoaddress: marker['address'] ??
                          'Musterstraße 11, 1312 Musterstadt',
                      infoopenhrs: marker['opnhrs'] ?? ' Musteröffnungszeiten',
                      infospecial: marker['special'] ?? '',
                      infotext: marker['text'] ??
                          'Bestes Muster Sportzentrum in der Stadt!',
                    )),
          );
        },
      ));
    });
  }

// _getPoints() - AlertDialog PopUp mit Info über gutgeschriebene Punkte
  void _getPoints() {
    if (_alreadyWorkout == true)
      return;
    else {
      showDialog(
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
          });
      _alreadyWorkout = true;
    }
  }

// checkLocationMarker - befindet sich User in gewünschtem Umkreis um SZ? Ja -> _getPoints() aufrufen
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

void setBackWorkout(){
  _alreadyWorkout = false;
}

  void _onMapCreated(GoogleMapController _cntrl) {
    //var location = _location.getLocation();
    setState(() {});
    _location.onLocationChanged().listen((l) {
      checkLocationMarker(LatLng(l.latitude, l.longitude));
    });
  }

// makeListWidget für ListView Firestore
  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return ListTile(
        title: Text(document['name'] ?? '', style: Theme.of(context).textTheme.headline5,),
        subtitle: Text(document['category'] ?? 'Test',style: Theme.of(context).textTheme.bodyText2,),
        leading: Icon(Icons.fitness_center),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SpzInfo(
                      infocategory: document['category'] ?? 'Musterkategorie',
                      infotitle: document['name'] ?? 'Muster Sportzentrum',
                      infoaddress: document['address'] ??
                          'Musterstraße 11, 1312 Musterstadt',
                      infoopenhrs:
                          document['opnhrs'] ?? ' Musteröffnungszeiten',
                      infospecial: document['special'] ?? '',
                      infotext: document['text'] ??
                          'Bestes Muster Sportzentrum in der Stadt!',
                    )),
          );
        },
      );
    }).toList();
  }

// MaterialApp build, TabBar, AppBar, floatingActionButton(Filter), locationButton, Karten- & Listenansicht
  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
               actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.help,
                  color: blue,
                ),
                label: Text(
                  '',
                  style: GoogleFonts.spartan(
                      textStyle: TextStyle(color: Colors.black)),
                ),
                onPressed: () async {
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutInfo()),
                  );

                },
              )
            ],
            automaticallyImplyLeading: false,
            title: Text('Workout' , style:  Theme.of(context).textTheme.headline1,),
            backgroundColor: bgColor,
          
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.map,color: Colors.black,)),
                  Tab(icon: Icon(Icons.list, color: Colors.black,)),
                ],
                indicatorColor: blue,
                indicatorWeight: 3,
              ),
            ),
            body:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
             
              Container(
                child: GoogleMap(
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
              ),
               Container(
                child: StreamBuilder(
                    stream: Firestore.instance.collection('spz').snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: CircularProgressIndicator());
                        default:
                          return ListView(
                            children: makeListWidget(snapshot),
                          );
                      }
                    }),
              ),
            ]),
            // floatingActionButton: FloatingActionButton(onPressed: setBackWorkout),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            bottomNavigationBar: bottomBar(_currentIndex,context),
          )),
    );
  }
}
