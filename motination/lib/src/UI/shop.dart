import 'package:flutter/material.dart';

import 'package:motination/models/user.dart';
import 'package:motination/src/UI/challenge.dart';
import 'package:motination/src/UI/profile.dart';

import 'homescreen.dart';
import 'profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



/*Shoping Class UI Design
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
  
int _currentIndex = 3;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);  
  DateTime _dateTime = DateTime.now();

 
  Widget build(context) {
   
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: barColor,
      ),
      body: CupertinoDatePicker(
        initialDateTime: _dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (datetime){
          setState(() {
            _dateTime = datetime;     
          }
          );
        }
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