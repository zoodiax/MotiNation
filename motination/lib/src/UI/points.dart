
import 'package:flutter/material.dart';
import 'profile.dart';
import 'homescreen.dart';
import 'shop.dart';

import 'package:motination/services/database.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



/* Points Class UI Design
  Test Page for Points Control
  Content:  Points download/upload from Database User 
  Function: getPoints, loosePoints, getPointsFromSnapshot,  
*/



class Points extends StatefulWidget {
  final int points;

  Points({Key key, this.points}) : super (key:key);
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {


  int p = 0;
  int points = 0;
  int _currentIndex = 2;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  
  final wrktColor = const Color (0xFF28CCD3);
  final blackColor = const Color(0xBF000000);
  
  DocumentSnapshot doc;
 
  void getPoints(){
    setState(() {
      p += 10;
    });
  }

void loosePoints(){
    setState(() {
      p -= 10;
    });
  }

// gets Points-Data from DocumentSnapshot to Variable
void getPointsfromSnapshot(DocumentSnapshot snapshot){
  Map<String, dynamic> data = snapshot.data;
  setState(() {
    points = data["points"];
  }); 
}
  

  @override
  Widget build(BuildContext context) {

   User user = Provider.of<User>(context);
  

   
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Points'),
      ),

      body: Container(

        child: Column(
          children:  [
              Spacer(),
              Text('Points added: ' + p.toString(),style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500,fontSize: 25),),
              Text('Points from Database: ' + points.toString(), style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500, fontSize: 25),),
              ButtonBar(alignment: MainAxisAlignment.center, children: [
        RaisedButton(
          onPressed: getPoints,
          color: Colors.blue,
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(300)),
        ),
        RaisedButton(
          onPressed: loosePoints,
          color: Colors.blue,
          child: Icon(Icons.remove),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(300)),
        ),
        RaisedButton(
          onPressed: () async {
                doc = await DatabaseService(uid: user.uid).getData(user);
                getPointsfromSnapshot(doc);
                
          },
          color: Colors.blue,
          child: Icon(Icons.archive),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(300)),
        ),
        RaisedButton(
          onPressed: () async {await DatabaseService(uid: user.uid).updatePoints(points+p);
          setState(() {
            p=0;
          });
          
          },
          color: Colors.blue,
          child: Icon(Icons.publish),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(300)),
        ),
      ]),     
      Spacer(),
          ],
        ), 
       
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
            title: Text('Points'),
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
            if (_currentIndex == 0)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
          });
        },
      ),
    );
  }
}