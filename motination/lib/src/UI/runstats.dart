import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motination/models/user.dart';
import 'package:motination/shared/constants.dart';
import 'package:motination/src/UI/runstatsdetails.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Runstats extends StatefulWidget {
  @override
  _RunstatsState createState() => _RunstatsState();
}

class _RunstatsState extends State<Runstats> {
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);

  final wrktColor = const Color(0xFF28CCD3);
  final blackColor = const Color(0xBF000000);
  //final CollectionReference userCollection = Firestore.instance.collection('user');

  final int sumdistanz = 0;

  String randerdatum(String datum){
    return datum.substring(0,9);
  }
    

  Icon sporttype(String type) {
    if (type == 'running')
      return Icon(
        Icons.directions_run_rounded,
        color: mainColor,
      );
    else
      return Icon(
        Icons.directions_bike,
        color: buttonColor,
      );
  }

// makeListWidget für ListView Firestore
  List<Widget> makeListWidgetUser(AsyncSnapshot snapshot) {
    return snapshot.data.documents.map<Widget>((document) {
      return Card(
        color: boxColor,
        child: ListTile(
          title: Text('Datum: ' +
                  randerdatum(document['date']??'') +
                  
                  '  ' +
                  'Distanz: ' + 
                  document['distanz']  + ' km',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,)
                  ) ,
                  
          subtitle: Text('Dauer: ' + document['time']  + ' min'),
          leading: sporttype(document['sportType']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            MaterialIcons.monetization_on,
            color: Colors.yellow,
          ), 
          Text(
            document['points'],
            style: TextStyle(
              color: Colors.black
            ),
          )
              
            ],
          ),

          /* Icons.directions_run_rounded,
          color: mainColor,
          ),*/
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RunStatsDetails(
                        currentdistanz: document['distanz'] ?? 'fauler Hund',
                        currentdate: document['date'] ?? '0',
                        currenttime: document['time'] ?? '0',
                        currentkcal: document['kcal'] ?? '0',
                      )),
            );
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return new Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Run Statistik',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('user')
                .document(user.uid)
                .collection('Run')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: boxColor,
                  child: Center(
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                );
              } else {
                return ListView(
                  padding: EdgeInsets.all(20.0),
                  children: makeListWidgetUser(snapshot),
                );
              }
            }),
      ),

      /*bottomNavigationBar: BottomNavigationBar(
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
            if (_currentIndex == 0)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
          });
        },
      ),*/
    );
  }
}
