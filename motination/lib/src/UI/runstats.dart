import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Runstats extends StatefulWidget {
  @override
  _RunstatsState createState() => _RunstatsState();
}

class _RunstatsState extends State<Runstats> {
  
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  
  final wrktColor = const Color (0xFF28CCD3);
  final blackColor = const Color(0xBF000000);
  final CollectionReference userCollection = Firestore.instance.collection('user');


// makeListWidget für ListView Firestore
  List<Widget> makeListWidgetUser(AsyncSnapshot snapshot) {
    
    return snapshot.data.documents.map<Widget>((document) {
    
      return ListTile(
        title: Text(document['distanz']+' '+document['time'] ?? ''),
        subtitle: Text(document['kcal'] ?? ''),
        leading: Icon(Icons.person),
       
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Run Statistik'),
      ),

      body: Container(
        child: StreamBuilder(
          stream: userCollection.document('uid').collection('Run').snapshots(),
          builder: (context,snapshot) {
            if (!snapshot.hasData) {
              return Container(
                color: Colors.blue,
                child: Center(
                  child: SpinKitRotatingCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            } else{
                return ListView(
                  padding: EdgeInsets.all(10.0),
                  children: makeListWidgetUser(snapshot),
                  );
            }
          }
        ),
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