import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:motination/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RunStatsDetails extends StatelessWidget {
  RunStatsDetails({
    this.currentdistanz = '0',
    this.currentdate = '0',
    this.currenttime = '0',
    this.currentkcal = '0',
  });
  final currentdistanz;
  final currentdate;
  final currenttime;
  final currentkcal;
  final boxColor = Colors.white70;

  String titledate(String datum){
    return datum.substring(0,9);
  }

  LatLng _initialPosition = LatLng(37.3318095, -122.030598);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: bgColor,
          title: Text('Lauf vom: ' + titledate(currentdate),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
      body:
          /*Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*Expanded(
            child: Image(
              image: NetworkImage('https://media-exp1.licdn.com/dms/image/C4D03AQG3wibhAzXXCA/profile-displayphoto-shrink_800_800/0?e=1610582400&v=beta&t=_0g4xt4l8w_t0issy2U_SXB9DWwnVVKpnIwPJYoqJ_8'),
            ))*/*/

          Column(children: <Widget>[
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
                myLocationButtonEnabled: false,
              ),
            )),

        Expanded(
            flex: 5,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 15,
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Center(
                  child: Container(
                    height: 150,
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
                          currentdistanz + ' km',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 150,
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
                          currenttime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 150,
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
                          currentkcal,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 150,
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
                          currentdistanz,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 175,
                    height: 150,
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
                          currentdistanz + ' m',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 150,
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
                          currentdistanz + ' m',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
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
