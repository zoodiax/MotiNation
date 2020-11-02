import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motination/src/UI/challenge.dart';
import 'package:motination/src/UI/profile.dart';

import 'homescreen.dart';
import 'profile.dart';


/* Shoping Class UI Design
  Test Page for Backend Test
  Content:  Bottom Navigation Bar
  Function: MaterialPageRoute -> (Profile, Homescreen, Challenge) 
*/

class Shoping extends StatefulWidget {
  @override
  createState() {
    return ShopState();
  }
}

class ShopState extends State<Shoping> {


// makeListWidget für ListView Firestore
  List<Widget> makeListWidget(AsyncSnapshot snapshot) {
    
    return snapshot.data.documents.map<Widget>((document) {
      
      return ListTile(
        title: Text(document['name'] ?? ''),
        subtitle: Text(document['category'] ?? 'Test'),
        leading: Icon(Icons.fitness_center),
      //   onTap: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //           builder: (context) => SpzInfo(
      //                 infocategory: document['category'] ?? 'Musterkategorie',
      //                 infotitle: document['name'] ?? 'Muster Sportzentrum',
      //                 infoaddress: document['address'] ?? 'Musterstraße 11, 1312 Musterstadt',
      //                 infoopenhrs: document['opnhrs'] ?? ' Musteröffnungszeiten',
      //                 infospecial: document['special'] ?? '',
      //                 infotext: document['text'] ?? 'Bestes Muster Sportzentrum in der Stadt!',
                     
      //               )),
      //     );
      //   },
       );
    }).toList();
  }


  int _currentIndex = 3;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  Widget build(context) {
   
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: barColor,
      ),
      body: Container(
        child: StreamBuilder(
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
