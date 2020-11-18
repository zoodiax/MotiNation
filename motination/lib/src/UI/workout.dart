import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:motination/src/UI/challenge.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';
import 'infospz.dart';
import 'package:location/location.dart';
import 'package:filter_list/filter_list.dart';


import 'spzinfo.dart';



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

// Lister mit Filterfunktionen für ListView und _openFilterList
class Category {
  Category({
    this.title,
    this.pool = false,
    this.gym = false,
    this.unisport = false,
    this.icon,
    this.openhrs,
    this.address,
    this.name,
    this.special,
    this.info,
  });
  String info;
  String title;
  bool pool;
  bool gym;
  bool unisport;
  IconData icon;
  String openhrs;
  String address;
  String special;
  String name;
}

// Liste Kategorien für ListView - Wichtig: info füllen für Zuweisung mit Infospz Class (siehe Ende Workout Class)
List<Category> allCategories = [
  new Category(
      title: "dasStadtwerk.Hallenbad",
      pool: true,
      icon: Icons.pool,
      info: '/a'),
  new Category(
      title: "FitnessFirst", gym: true, icon: Icons.fitness_center, info: '/b'),
  new Category(
      title: "Unisport Regensburg",
      unisport: true,
      icon: Icons.fitness_center,
      info: '/c'),
  new Category(
    title: 'dasStadwerk.Wöhrdbad',
    pool: true,
    icon: Icons.pool,
    info: '/d',
  ),
  new Category(
    title: 'dasStadwerk.Westbad',
    pool: true,
    icon: Icons.pool,
    info: '/e',
  ),
];

// Class Marker - Wichtig für Markeraufbau in MapView - Filterfunktion nach bool (z.b. gym, pool)
class Markerz extends Marker {
  Markerz(
      {this.markerId,
      this.position,
      this.pool = false,
      this.gym = false,
      this.unisport = false,
      this.infoWindow,
      this.onTap});
  final MarkerId markerId;
  final LatLng position;
  final bool pool;
  final bool gym;
  final bool unisport;
  final InfoWindow infoWindow;
  final VoidCallback onTap;
}

// Liste mit allen Marker - wird in initState gefüllt
List<Markerz> allMarkers = [];

class WorkoutState extends State<Workout> {
  LatLng _initialPosition = LatLng(49.017214, 12.097498);
  // GoogleMapController _controller;
  Location _location = Location();
  bool _alreadyWorkout = false;
  int _currentIndex = 2;
  Markerz hlpmarker;


  // countList Filteroptinen
  List<String> countList = [
    "Schwimmbad",
    "Fitness",
    "Hochschulsport",
  ];

// selectedCountList für Filter nach Namen -> abgeleich ob Strings mit countList übereinstimmen, dann danach suchen
  List<String> selectedCountList = [];

// slectedSpz Sportzentren gefiltert in Listenansicht
  List<Category> selectedSpz = [];

// selectedMarkers Sportzentren gefilter in Kartenansicht
  List<Markerz> selectedMarkers = [];

  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final black = const Color(0xFF000000);


void fillMarker(){
    setState(() {
        
    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker1'),
      position: LatLng(49.015982, 12.107087),
      infoWindow: InfoWindow(title: ('das Stadtwerk.Hallenbad')),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoHallenbad()));
      },
      pool: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker2'),
      position: LatLng(48.992637, 12.098951),
      infoWindow: InfoWindow(title: ('Unisport Regensburg')),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoUnisport()));
      },
      unisport: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker3'),
      position: LatLng(49.012260, 12.096680),
      infoWindow: InfoWindow(
        title: ('Fitness First'),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfoFitnessFirst()));
      },
      gym: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker4'),
      position: LatLng(49.025150, 12.086251),
      infoWindow: InfoWindow(
        title: ('dasStadtwerk.Wöhrdbad'),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoWoehrdbad()));
      },
      pool: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker5'),
      position: LatLng(49.024390, 12.054341),
      infoWindow: InfoWindow(
        title: ('dasStadtwerk.Westbad'),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoWestbad()));
      },
      pool: true,
    ));
     });
}

// initState() -Markerz hinzufügen, WICHTIG: eine Filterfunktion auf true setzen (bsp gym, pool)
  @override
  void initState() {
    super.initState();
    fillMarker();

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

  void _onMapCreated(GoogleMapController _cntrl) {
    // _controller = _cntrl;
    //var location = _location.getLocation();
    setState(() {
      
    });
    _location.onLocationChanged().listen((l) {
      checkLocationMarker(LatLng(l.latitude, l.longitude));
    });
  }

// _openFilterList FilterFunktion, aufrufen der einzelnen Kategorien und hinzufügen zu selectedSpz und selectedMarkers
  void _openFilterList() async {
    selectedSpz.clear();
    selectedMarkers.clear();
    var list = await FilterList.showFilterList(
      context,
      allTextList: countList,
      height: 450,
      borderRadius: 20,
      headlineText: "Kategorie wählen",
      hideSearchField: true,
      selectedTextList: selectedCountList,
    );

    if (list != null) {
      setState(() {
        selectedCountList = List.from(list);
      });
      for (int i = 0; i < selectedCountList.length; i++) {
        List<Category> searchCategory = [];
        List<Markerz> searchMarker = [];

        if (selectedCountList[i] == "Schwimmbad") {
          searchCategory = allCategories.where((i) => i.pool).toList();
          searchMarker = allMarkers.where((i) => i.pool).toList();
        }
        if (selectedCountList[i] == "Fitness") {
          searchCategory = allCategories.where((i) => i.gym).toList();
          searchMarker = allMarkers.where((i) => i.gym).toList();
        }
        if (selectedCountList[i] == "Hochschulsport") {
          searchCategory = allCategories.where((i) => i.unisport).toList();
          searchMarker = allMarkers.where((i) => i.unisport).toList();
        }
        for (int j = 0; j < searchMarker.length; j++) {
          selectedSpz.add(searchCategory[j]);
          selectedMarkers.add(searchMarker[j]);
        }
      }
    }
  }

// makeListWidget für ListView Firestore
  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    
    return snapshot.data.documents.map<Widget>((document) {
      var icon;
      double lat = double.parse(document['lat'] ?? '0');
      double lng = double.parse(document['lng'] ?? '0'); 

      allMarkers.add(Markerz(
      markerId: MarkerId(document['name']),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: (document['name']),
      ),
      pool: true,
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SpzInfo(
                      infocategory: document['category'] ?? 'Musterkategorie',
                      infotitle: document['name'] ?? 'Muster Sportzentrum',
                      infoaddress: document['address'] ?? 'Musterstraße 11, 1312 Musterstadt',
                      infoopenhrs: document['opnhrs'] ?? ' Musteröffnungszeiten',
                      infospecial: document['special'] ?? '',
                      infotext: document['text'] ??'Bestes Muster Sportzentrum in der Stadt!',
                      
                    )),
          );}));
   

      (document['pool'] == true) ? icon = Icons.pool : null;
      (document['gym'] == true) ? icon = Icons.fitness_center : null;
      return ListTile(
        title: Text(document['name'] ?? ''),
        subtitle: Text(document['category'] ?? 'Test'),
        leading: Icon(icon ?? Icons.fitness_center),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SpzInfo(
                      infocategory: document['category'] ?? 'Musterkategorie',
                      infotitle: document['name'] ?? 'Muster Sportzentrum',
                      infoaddress: document['address'] ?? 'Musterstraße 11, 1312 Musterstadt',
                      infoopenhrs: document['opnhrs'] ?? ' Musteröffnungszeiten',
                      infospecial: document['special'] ?? '',
                      infotext: document['text'] ?? 'Bestes Muster Sportzentrum in der Stadt!',
                     
                    )),
          );
        },
      );
    }).toList();
  }



// MaterialApp build, TabBar, AppBar, floatingActionButton(Filter), locationButton, Karten- & Listenansicht
// WICHTIG: Am Ende Inforouten angeben für aufruf der Infospz.dart files
  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Workout'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.list)),
                  Tab(icon: Icon(Icons.map)),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _openFilterList,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              Container(
                child:
                    //new version with firebase
                    StreamBuilder(
                        stream:
                            Firestore.instance.collection('spz').snapshots(),
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
                markers:
                    selectedCountList == null || selectedCountList.length == 0
                        ? Set.from(allMarkers)
                        : Set.from(selectedMarkers),
              ),
              

            ]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 1,
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
                  if (_currentIndex == 1)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  if (_currentIndex == 0)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  if (_currentIndex == 2)
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
          )),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => InfoHallenbad(),
        '/b': (BuildContext context) => InfoFitnessFirst(),
        '/c': (BuildContext context) => InfoUnisport(),
        '/d': (BuildContext context) => InfoWoehrdbad(),
        '/e': (BuildContext context) => InfoWestbad(),
      },
    );
  }
}
