

import 'package:flutter/material.dart';

import 'package:motination/src/UI/challenge.dart';

import 'homescreen.dart';
import 'profile.dart';
import 'shop.dart';

import 'package:motination/services/database.dart';

import 'package:motination/models/user.dart';

import 'package:motination/src/UI/profile.dart';
import 'package:provider/provider.dart';



class SaveRun extends StatefulWidget {
  final int dis;
  final int kcal;
  final int time;
 
  SaveRun({Key key, this.dis, this.kcal, this.time}) : super (key:key);
  @override
  _SaveRunState createState() => new _SaveRunState();
}

class _SaveRunState extends State<SaveRun> {
 
int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);


  Widget build(context) {
    User user = Provider.of<User>(context);

    return new Scaffold(
      
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('SaveRun'),
        backgroundColor: barColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column (children: <Widget> [ 
          Spacer(),
          Text('Gratulation!', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
          Text(''),
          Text('Deine Laufergebnisse:'),
          Text(''),
          Text('Distanz in m: ' +widget.dis.toString() + '    Verbrannte Kcal: ' +  widget.kcal.toString()+ '   Gelaufene Zeit in sec: ' + widget.time.toString()),
          Spacer(),


        ]),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async {
      
        await DatabaseService(uid: user.uid).updateRunData(widget.dis.toString(), widget.kcal.toString(), widget.time.toString());
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
