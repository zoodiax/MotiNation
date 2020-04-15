import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';
import 'package:location/location.dart';
import 'package:filter_list/filter_list.dart';

class Workout extends StatefulWidget {
  createState() {
    return WorkoutState();
  }
}

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
];

class Infospz extends StatelessWidget {
  Infospz({
    this.infotitle,
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text(infotitle),
            subtitle: Text(infoname),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:'),
            subtitle: Text(infoopenhrs),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse'),
            subtitle: Text(infoaddress),
          ),
          Divider(),
          ListTile(title: Text('Aktion'), subtitle: Text(infospecial)),
        ])),
      ),
    );
  }
}

class InfoHallenbad extends StatelessWidget {
  InfoHallenbad({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.pool),
          ListTile(
            title: Text('das Stadtwerk.Hallenbad'),
            subtitle: Text(infoname),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:'),
            subtitle: Text(infoopenhrs),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse'),
            subtitle: Text(infoaddress),
          ),
          Divider(),
          ListTile(title: Text('Aktion'), subtitle: Text(infospecial)),
        ])),
      ),
    );
  }
}

class InfoFitnessFirst extends StatelessWidget {
  InfoFitnessFirst({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text('Fitness First'),
            subtitle: Text(infoname),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:'),
            subtitle: Text(infoopenhrs),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse'),
            subtitle: Text(infoaddress),
          ),
          Divider(),
          ListTile(title: Text('Aktion'), subtitle: Text(infospecial)),
        ])),
      ),
    );
  }
}

class InfoUnisport extends StatelessWidget {
  InfoUnisport({
    this.infotitle = 'Name',
    this.infoopenhrs = 'Hier stehen die Öffnungszeiten',
    this.infoaddress = 'Hier steht die Adresse',
    this.infoname = 'Hier gibt es die Informationen über das Sportzentrum',
    this.infospecial =
        'Hier stehen Aktionen, falls das Sportzentrum Premium Partner ist',
  });
  final String infotitle;
  final String infoopenhrs;
  final String infoaddress;
  final String infospecial;
  final String infoname;
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Sportzentrum'),
      ),
      body: Center(
        child: Card(
            child: Column(children: [
          Icon(Icons.fitness_center),
          ListTile(
            title: Text('Unisport'),
            subtitle: Text(infoname),
          ),
          Divider(),
          ListTile(
            title: Text('Öffnungszeiten:'),
            subtitle: Text(infoopenhrs),
          ),
          Divider(),
          ListTile(
            title: Text('Adresse'),
            subtitle: Text(infoaddress),
          ),
          Divider(),
          ListTile(title: Text('Aktion'), subtitle: Text(infospecial)),
        ])),
      ),
    );
  }
}

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

void openSite() {}
List<Markerz> allMarkers = [
  // new Markerz(
  //   markerId: MarkerId('marker1'),
  //   position: LatLng(49.015982, 12.107087),
  //   infoWindow: InfoWindow(title: ('das Stadtwerk.Hallenbad')),
  //   pool: true,
  //   onTap: (){
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => InfoHallenbad()));
  //   },
  // ),

  // new Markerz(
  //   markerId: MarkerId('marker2'),
  //   position: LatLng(49.012260, 12.096680),
  //   gym: true,
  // )
];

class WorkoutState extends State<Workout> {
  LatLng _initialPosition = LatLng(49.017214, 12.097498);
  // GoogleMapController _controller;
  Location _location = Location();
  // List<Markerz> allMarkers = [];
  bool _alreadyWorkout = false;
  int _currentIndex = 2;
  List<String> countList = [
    "Schwimmbad",
    "Fitness",
    "Hochschulsport",
  ];

  List<String> selectedCountList = [];
  List<Category> selectedSpz = [];
  List<Markerz> selectedMarkers = [];

  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final black = const Color(0xFF000000);

  // void _marker1tap() {
  //   (showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             title: Text('das Stadtwerk.Hallenbad'),
  //             content: Text(
  //                 'Kategorie:   Hallenschwimmbad  Addresse:   Gabelsbergerstr. 14 Telefon:       0941 6012977 '),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(22)),
  //             backgroundColor: bgColor,
  //             contentTextStyle: TextStyle(color: black, fontSize: 18),
  //             titleTextStyle: TextStyle(color: barColor, fontSize: 25));
  //       }));
  // }

  // void _marker2tap() {
  //   (showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             title: Text('Unisport Regensburg'),
  //             content: Text(
  //                 'Kategorie:   Universitätssport  Addresse:   Am Biopark 12      Telefon:       0941 9432507 '),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(22)),
  //             backgroundColor: bgColor,
  //             contentTextStyle: TextStyle(color: black, fontSize: 18),
  //             titleTextStyle: TextStyle(color: barColor, fontSize: 25));
  //       }));
  // }

  // void _marker3tap() {
  //   (showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             title: Text('Fitness First'),
  //             content: Text(
  //                 'Kategorie:   Fitnessstudio  Addresse:   Bahnhofstr. 12    Telefon:       0941 584070 '),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(22)),
  //             backgroundColor: bgColor,
  //             contentTextStyle: TextStyle(color: black, fontSize: 18),
  //             titleTextStyle: TextStyle(color: barColor, fontSize: 25));
  //       }));
  // }

  @override
  void initState() {
    super.initState();

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker1'),
      // draggable: false,
      position: LatLng(49.015982, 12.107087),
      infoWindow: InfoWindow(title: ('das Stadtwerk.Hallenbad')),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoHallenbad()));

        // Navigator.pushNamed(context, '/a' );

        //_marker1tap();
      },
      pool: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker2'),
      // draggable: false,
      position: LatLng(48.992637, 12.098951),
      infoWindow: InfoWindow(title: ('Unisport Regensburg')),
      onTap: () {
        // _marker2tap();
        //Navigator.pushNamed(context, '/b');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InfoUnisport()));
      },
      unisport: true,
    ));

    allMarkers.add(Markerz(
      markerId: MarkerId('myMarker3'),
      // draggable: false,
      position: LatLng(49.012260, 12.096680),
      infoWindow: InfoWindow(
        title: ('Fitness First'),
      ),
      onTap: () {
        // _marker3tap();
        // Navigator.pushNamed(context, '/c' );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfoFitnessFirst()));
      },
      gym: true,
    ));
  }

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
    _location.onLocationChanged().listen((l) {
      checkLocationMarker(LatLng(l.latitude, l.longitude));
    });
  }

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
        for (int j = 0; j < searchCategory.length; j++) {
          selectedSpz.add(searchCategory[j]);
          selectedMarkers.add(searchMarker[j]);
        }
      }
    }
  }

  Widget build(context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Workout'),
              //backgroundColor: barColor,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.map)),
                  Tab(icon: Icon(Icons.list)),
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
              Container(
                child:
                    selectedCountList == null || selectedCountList.length == 0
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(allCategories[index].title),
                                leading: Icon(allCategories[index].icon),
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => infospz(
                                  //             infotitle:
                                  //                 allCategories[index].title)));
                                  Navigator.pushNamed(
                                      context, allCategories[index].info);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: allCategories.length)
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(selectedSpz[index].title),
                                leading: Icon(selectedSpz[index].icon),
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => infospz(
                                  //             infotitle:
                                  //                 selectedSpz[index].title)));
                                  Navigator.pushNamed(
                                      context, selectedSpz[index].info);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: selectedSpz.length),
              )
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
                  if(_currentIndex ==2)
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Shoping()),
                    );
                    
                });
              },
            ),
          )),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => InfoHallenbad(),
        '/b': (BuildContext context) => InfoFitnessFirst(),
        '/c': (BuildContext context) => InfoUnisport(),
      },
    );
  }
}
