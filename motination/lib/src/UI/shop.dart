import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shoping extends StatefulWidget {
  @override
  createState() {
    return ShopState();
  }
}

class ShopState extends State<Shoping> {




  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  Widget build(context) {
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: barColor,
      ),
      body: StreamBuilder(stream: Firestore.instance.collection('workout').snapshots(),
      builder: (context, snapshot){
        return Column(children: <Widget>[
          Text(snapshot.data.documents[0]['name']),

          Text(snapshot.data.documents[0]['ort']),
        ]);    
      },),
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
          });
        },
      ),
    );
  }
}
