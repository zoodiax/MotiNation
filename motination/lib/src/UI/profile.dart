import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/shared/constants.dart';

import 'package:motination/src/UI/runstats.dart';
import 'package:motination/src/UI/settings.dart';
import 'package:motination/src/UI/workoutstats.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/bottomBar.dart';


import 'package:motination/services/database.dart';

/* Profile Class UI Design
  Content: User Information, Profile Settings Button, Bottom Navigation Bar
  Function:  MaterialPageRoute -> (Settings, Home, Challenge, Shop) 
  Stream Builder for Firebase Backend Information 
*/

class Profile extends StatefulWidget {
  @override
  createState() {
    return _ProfileState();
  }
}

 
class _ProfileState extends State<Profile> {
  int _currentIndex = 0;
  int _groese;
  double currentgewicht;
  String vorname;
  String nachname;
  String benutzername;
  String sumdistanz;
  String sumtime;
  String sumspeed;
  double bmi;
  Future<void> getData(User user) async {
    try {
      DocumentSnapshot snapshot =
          await DatabaseService(uid: user.uid).getUserData();
      Map<String, dynamic> data = snapshot.data;
      setState(() {
        _groese = data['height'];
        currentgewicht = data['weight'];
        vorname = data['firstname'];
        nachname = data['lastname'];
        benutzername = data['username'];
        sumdistanz = data['sumdistance'];
        sumtime = data['sumtime'];
        sumspeed = data['sumspeed'];
      });
    } catch (err) {
      print(err.toString());
    }
  }

  void _bmirechner() {
    bmi = currentgewicht / ((_groese / 100) * _groese / 100);
  }

  String showDistance(String distance){
    double m = double.parse(distance);
    assert (m is double);
    double km = m/1000;
    return km.toStringAsFixed(2);
  }

  String randerbmi(String date) {
    return date.substring(0, 2);
  }

  Widget build(context) {
    User user = Provider.of<User>(context);
    getData(user);
    _bmirechner();
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: bgColor,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings, color: Colors.black),
            label: Text(''),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings())),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C4D03AQG3wibhAzXXCA/profile-displayphoto-shrink_800_800/0/1573047022324?e=1620864000&v=beta&t=i8P6Wa3m9dkG06QzV3cDUQIXjjoe7TEs21EaHlCqmVI'),
                  ),
                ),
              ),
              Container(height:10.0),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        vorname + ' ' + nachname,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        benutzername,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Größe: ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(_groese.toString() + 'cm',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Gewicht: ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(currentgewicht.toString() + ' kg',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'BMI: ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(randerbmi(bmi.toString()),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(height: 20.0), 
              Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Gesamtstatistik',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: boxColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.teal[900],
                      child: Icon(Icons.directions_run,
                          size: 30, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Runstats()),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                showDistance(sumdistanz),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Kilomter',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                sumtime,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Stunden',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                sumspeed,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Speed',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(height: 10.0),

              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: boxColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: null,
                      backgroundColor: buttonColor,
                      child: Icon(Icons.fitness_center_rounded,
                          size: 30, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutStats()),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              '15',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Besuche',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '35',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Stunden',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
      ),
      ),
      
      bottomNavigationBar: bottomBar(_currentIndex, context),
    );
  }
}
