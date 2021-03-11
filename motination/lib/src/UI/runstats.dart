import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motination/models/user.dart';
import 'package:motination/shared/constants.dart';
import 'package:motination/src/UI/runstatsdetails.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

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
    return datum.substring(0,10);
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
    //Datum umschreiben
    String showDate(String date){
      var inputFormat = DateFormat('yyyy-MM-dd');
      var inputDate = inputFormat.parse(date); 

    var outputFormat = DateFormat('dd.MM.yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
    }

    //Zeit in Stoppuhr Format anzeigen
    String showTime(String second) {
      int seconds = int.parse(second);
      int s = seconds;
      return (Duration(seconds: s).inHours.toString().padLeft(2, '0') +
      ':' +
      (Duration(seconds: s).inMinutes % 60).toString().padLeft(2, '0') +
      ':' + 
      (Duration(seconds: s).inSeconds % 60).toString().padLeft(2, '0'));
    }

   /*sectomin(String seconds){
    double sec = double.parse(seconds);
    assert (sec is double);
    double min = sec/60;
    return min.toStringAsPrecision(2);
  }*/
  // Funktion für Meter in Kilometer
    mtokm(String meter){
    double m = double.parse(meter);
    assert (m is double);
    double km = m/1000;
    return km.toStringAsFixed(2);
  }
  //Rander Meter auf 2. Nachkommastellen Ziffern

// makeListWidget für ListView Firestore
  List<Widget> makeListWidgetUser(AsyncSnapshot snapshot) {

    return snapshot.data.documents.map<Widget>((document) {
      return Card(
        
        color: boxColor,
        child: ListTile(
          title:
          Text(
            'Datum: ' +
                  showDate(randerdatum(document['date']??'')) +
                  
                  '                       ' +
                  'Distanz: ' + mtokm(document['distance']).toString()  + ' km',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  
                  ) ,
                  
          subtitle: Text('Dauer: ' + showTime(document['time']).toString()  + ' Min'),
          leading: sporttype(document['sportType']),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(
            MaterialIcons.monetization_on,
            color: Colors.yellow,
          ), 
          Text(
            document['points'].toString(),
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
                        document : document,
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
