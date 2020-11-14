

import 'package:flutter/material.dart';

import 'package:motination/src/UI/challenge.dart';

import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';

import 'package:motination/services/database.dart';

import 'package:motination/models/user.dart';

import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaveRun extends StatefulWidget {
  final int dis;
  final int kcal;
  final int time;
  List<LatLng> latlng;
  final Set<Polyline> polyline;
  List <double> altitude;
 
  SaveRun({Key key, this.dis, this.kcal, this.time, this.latlng, this.polyline, this.altitude}) : super (key:key);
  @override
  _SaveRunState createState() => new _SaveRunState();
}

class _SaveRunState extends State<SaveRun> {
 
int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  LatLng _initialPosition = LatLng(37.3318095, -122.030598);
  final Set<Polyline> _polyline = {};
  final List <double> lat = [];
  final List <double> lng = [];
  final List <double> alt = [];
  
  double latmin,latmax,lngmin,lngmax, latinit, lnginit;
  void buildPolyline(List<LatLng> list){
  
     _polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: list,
          color: Colors.blue,
          width: 4,
        ));
  
  }

void data2collection(List<LatLng> list, List <double> altitude){
  latmin = list[0].latitude;
  lngmin = list[0].longitude;
  latmax = list[0].latitude;
  lngmax = list[0].longitude;

  for (int i = 0; i<list.length; i++)
    {
      lat.add(list[i].latitude);
      lng.add(list[i].longitude);
      latlngmax(list[i].latitude, list[i].longitude);
  
    }
  for (int i= 0; i<altitude.length;i++)
  {
    alt.add(altitude[i]);
  }
  
  }

void latlngmax(double lat, double lng){
  if (latmin > lat) {latmin = lat;}
  if (latmax < lat) {latmax = lat;}
  if (lngmin  > lng) {lngmin = lng;}
  if (lngmax < lng) {lngmax = lng;}
}


void initposition(){
  lnginit = (lngmax + lngmin) /2;
  latinit = (latmax + latmin) /2;
  setState(() {
    _initialPosition = LatLng(latinit,lnginit);
  });
}



  Widget build(context) {
    User user = Provider.of<User>(context);
    buildPolyline(widget.latlng);
    data2collection(widget.latlng, widget.altitude);
   
    

    return new Scaffold(
      
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('SaveRun'),
        backgroundColor: barColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column (children: <Widget> [ 
          Expanded(flex:2, child:GoogleMap(
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
                  

                ),),
         Expanded(flex:3 , child: Column(
           children: <Widget>[ Spacer(),
          Text('Gratulation!', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
          Text(''),
          Text('Deine Laufergebnisse:'),
          Text(''),
          Text('Distanz in m: ' +widget.dis.toString() + '    Verbrannte Kcal: ' +  widget.kcal.toString()+ '   Gelaufene Zeit in sec: ' + widget.time.toString()),
          Spacer(),
         // Text('LatLng:' + widget.latlng.toString()),
          Spacer(),
          Text('Lat: ' +lat.toString()),
          Spacer(),
          Text('Lng: '+ lng.toString()),
          Spacer(),
          Text('altitude : ' + widget.altitude.toString()),
          Spacer(),
          Spacer(),
          Spacer(),
          Spacer(),
          ],
         ))
         


        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async {
        await DatabaseService(uid: user.uid).updateRunData(widget.dis.toString(), widget.kcal.toString(), widget.time.toString(), lat, lng,latinit,lnginit);
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
        },

         child: Icon(Icons.save),
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
