import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/src/UI/challenge.dart';
import 'package:motination/src/UI/settings.dart';
import 'package:provider/provider.dart';
import 'homescreen.dart';
import 'shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {


    


  int _currentIndex = 0;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  Widget build(context) {

    User user = Provider.of<User>(context);

    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Profile '),
        backgroundColor: barColor,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.settings,
              color: bgColor,
              ),
              label: Text(''),
            onPressed: () => Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Settings())),
            )
        ],
      ),
      
      body: StreamBuilder(
        stream: Firestore.instance.collection('user').document(user.uid).snapshots(),  /*DatabaseService(uid: user.uid).userData,*/
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return new Text('Loading');
          }
          
        return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          Expanded(
            child:Container(
            alignment: Alignment.center,
              height: 150,
              child: Icon(      //Profilbild
               Icons.person,
                color: Colors.grey[700],
                size: 100,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
          ),
          ),

                          Expanded(
                            child: Column(children: <Widget>[
                              Expanded(
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(snapshot.data['vorname']+' '+ snapshot.data['nachname'], 
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: bgColor,
                                  alignment: Alignment.topCenter,
                                  child: Text(snapshot.data['benutzername'], 
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                                ),
                              ),
                            ]),
                          ),

          Expanded(
          child: Column(
            children: <Widget>[
            Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      snapshot.data['alter'],
            
                      style: TextStyle( color: Colors.grey[500], fontSize: 15),
                      textAlign: TextAlign.center,
                      ),
                     ),
                  Expanded(
                    child: Text(
                      snapshot.data['groese'], 
                      style: TextStyle(color: Colors.blueGrey[500], fontSize: 15),
                      textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      snapshot.data['gewicht'],
                      style: TextStyle(color: Colors.grey[700], fontSize:15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            
            Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Alter', 
                      style: TextStyle( color: Colors.grey[500], fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Größe', 
                      style: TextStyle(color: Colors.blueGrey[500], fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Gewicht',
                      style: TextStyle(color: Colors.grey[700], fontSize:10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            
            ],
          ),
          ),
          
    
          Expanded(
            child: Column(
              children: <Widget> [
                Container(
                  height: 50,
                  child: Icon(
                    Icons.directions_run,
                    color: Colors.white,
                    size: 30,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue
                  ),
                ), 
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '23482', 
                        style: TextStyle( color: Colors.grey[500], fontSize: 20),
                        textAlign: TextAlign.center
                      ),
                    ),
                    Expanded(
                      child: Text(
                      '70984', 
                      style: TextStyle(color: Colors.blueGrey[500], fontSize: 20),
                      textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '12,3 km/h',
                        style: TextStyle(color: Colors.grey[700], fontSize: 20), 
                        textAlign: TextAlign.center,       
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Meter', 
                        style: TextStyle( color: Colors.grey[500], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Minuten', 
                        style: TextStyle(color: Colors.blueGrey[500], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Geschwindigkeit', 
                        style: TextStyle(color: Colors.blueGrey[500], fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),

          Expanded(
            child: Column(
              children: <Widget>[
              Container(
                height: 60,
                child: Icon(
               Icons.fitness_center,
                color: Colors.white,
                size: 30,
                ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue
                
              ),
            ), 
            Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '14', 
                  style: TextStyle( color: Colors.grey[500], fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '7054', 
                  style: TextStyle(color: Colors.blueGrey[500], fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            ),
            Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Besuche', 
                  style: TextStyle( color: Colors.grey[500], fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  'Minuten', 
                  style: TextStyle(color: Colors.blueGrey[500], fontSize: 15, fontWeight: FontWeight.w700),                  
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            ),
          ],
        ),
          ),
        ],
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
