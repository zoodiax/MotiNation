import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';
import 'package:motination/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';



class RunStatsDetails extends StatelessWidget {
  RunStatsDetails({
  
    this.document,
  });

  final DocumentSnapshot document;




  final boxColor = Colors.white70;
  // final Set<Polyline> _polyline = {};

  final List<double> latlng = [];

  List<double> getList(List<dynamic> list) {
    List<double> dList = List<double>.from(list);
    return dList;
  }
   //Datum umschreiben
    String showDate(String date){
      var inputFormat = DateFormat('yyyy-MM-dd');
      var inputDate = inputFormat.parse(date); 

    var outputFormat = DateFormat('dd.MM.yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
    }

  List<LatLng> latLngList(List<double> lat, List<double> lng) {
    if (lat.length == lng.length) {
      List<LatLng> list = [];

      for (var i = 0; i < lat.length; i++) {
        list.add(LatLng(lat[i], lng[i]));
      }
      return list;
    } else {
      print('Lat.length != Lng.lengt');
      return null;
    }
  }

  String titledate(String datum) {
    return datum.substring(0, 10);
  }
   mtokm(String meter){
    double m = double.parse(meter);
    assert (m is double);
    double km = m/1000;
    return km.toStringAsFixed(2);
  }


 buildPolyline(List<LatLng> list) {
   Set<Polyline> _polyline = {};
   
     _polyline.add(Polyline(
      polylineId: PolylineId('route1'),
      visible: true,
      points: list,
      color: blue,
      width: 6));
  print(_polyline.toString());
  return _polyline;
 }

      String showTime(String second) {
      int seconds = int.parse(second);
      int s = seconds;
      return (Duration(seconds: s).inHours.toString().padLeft(2, '0') +
      ':' +
      (Duration(seconds: s).inMinutes % 60).toString().padLeft(2, '0') +
      ':' + 
      (Duration(seconds: s).inSeconds % 60).toString().padLeft(2, '0'));
    }
   
  
  Widget build(BuildContext context) {   
   
    List<double> lat = getList(document['lat']);
    List<double> lng = getList(document['lng']);
    List<LatLng> latlng = latLngList(lat, lng);
    LatLng _initialPosition = LatLng(document['latinit'],document['lnginit']);
     Set<Polyline> _polyline = buildPolyline(latlng);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: bgColor,
          title: Text('Lauf vom: ' + showDate(titledate(document['date'])),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      body: Column(children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: bgColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 16,
                ),
                polylines: _polyline,
                myLocationButtonEnabled: false,
              ),
            )),

        Expanded(
            flex: 5,
            child: GridView.count(
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Center(
                  child: Container(
                    height: 175,
                    width: 175,
                    //color: Colors.blue[100],
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
                        Text(
                          mtokm(document['distance']),
                          style: TextStyle(
                              fontStyle: FontStyle.normal,           
                              fontSize: 20),
                        ),
                        Text(
                          'Distanz [km]'
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 175,
                    width: 175,
                    //color: Colors.blueAccent[100],
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
                        Text(
                          showTime(document['time']),
                          style: TextStyle(
                               fontSize: 20),
                        ),
                        Text(
                          'Zeit',
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 175,
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
                          MaterialIcons.schedule,
                          color: Colors.blue[600],
                          size: 70,
                        ),
                        Spacer(),
                        Text(
                          document['tempo'],
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'ø Min/km'
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 175,
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
                          Icons.speed,
                          color: Colors.green[600],
                          size: 70,
                        ),
                        Spacer(), 
                        Text(
                          document['maxspeed'].toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'Max. km/h'
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 175,
                    width: 175,
                    //color: Colors.blueAccent[100],
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
                        Text(
                          document['kcal'],
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'Kalorien'
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 175,
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
                        Text(
                          document['points'].toString(),
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'Punkte'
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 175,
                    //color: Colors.blueAccent[200],
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
                        Text(
                          document['altitudeUp'].toString() + ' m',
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'Höhenmeter'
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 175,
                    width: 175,
                    //color: Colors.blue[200],
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
                          Icons.trending_down_rounded,
                          color: Colors.red,
                          size: 70,
                        ),
                        Spacer(),
                        Text(
                          document['altitudeDown'].toString() + ' m',
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          'Tiefenmeter'
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
        //],
        //),
      ]),
    );
  }

}