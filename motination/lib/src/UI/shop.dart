
import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/src/UI/challenge.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:provider/provider.dart';
import 'package:motination/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/user.dart';

import 'package:motination/services/database.dart';
import 'package:motination/models/user.dart';

import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';


/* Shoping Class UI Design
  Test Page for Backend Test
  Content:  Bottom Navigation Bar
  Function: MaterialPageRoute -> (Profile, Homescreen, Challenge) 
*/

class Shoping extends StatefulWidget { 
  final String uid;
  

  const Shoping({Key key, this.uid}) : super(key: key);
  @override
  createState() {
    return ShopState();

  }
}

class ShopState extends State<Shoping> {
  final _formKey = GlobalKey<FormState>();
 
  int _currentIndex = 3;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);  
  final CollectionReference activityCollection = Firestore.instance.collection('user');

  String duration = '0';
  String distance = '0';
  String calories;
  String date;
  String time; 


   String kcal = '10';
   String tmp = '200';
   String dis = '0.1';
  
  
  Widget build(context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: barColor,
      ),
      body: Container(
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
      
        await DatabaseService(uid: user.uid).updateRunData(dis, kcal, tmp);}),


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