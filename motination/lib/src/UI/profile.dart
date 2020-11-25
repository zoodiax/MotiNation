import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';

import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/shared/constants.dart';

import 'package:motination/src/UI/challenge.dart';
import 'package:motination/src/UI/runstats.dart';
import 'package:motination/src/UI/settings.dart';
import 'package:motination/src/UI/workoutstats.dart';

import 'package:provider/provider.dart';
import 'homescreen.dart';
import 'shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Widget build(context) {
    User user = Provider.of<User>(context);

    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('user')
            .document(user.uid)
            .snapshots(),
        /*DatabaseService(uid: user.uid).userData,*/
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text('Loading');
          }

          return Container(
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
                            'https://media-exp1.licdn.com/dms/image/C4D03AQG3wibhAzXXCA/profile-displayphoto-shrink_200_200/0/1573047022324?e=1611792000&v=beta&t=RF6cdGacErRqLLs90TuK1KW_H9jtKYplI_Z_9KJgc88'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            snapshot.data['vorname'] +
                                ' ' +
                                snapshot.data['nachname'],
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          child: Text(
                            snapshot.data['benutzername'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Alter: ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(snapshot.data['alter'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ))
                                ],
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
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(snapshot.data['groese'] + 'cm',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
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
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(snapshot.data['gewicht']+'kg',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                            spreadRadius: 5,
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
                              MaterialPageRoute(
                                  builder: (context) => Runstats()),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data['sumdistanz'],
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
                                  snapshot.data['sumtime'],
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
                                  snapshot.data['sumspeed'],
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
                      ],
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
                            spreadRadius: 5,
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
          );
        },
      ),
      
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
            if (_currentIndex == 3)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Shoping()),
              );
            if (_currentIndex == 1)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
