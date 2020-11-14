import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/src/UI/challenge.dart';

import 'workout.dart';
import 'profile.dart';
import 'shop.dart';
import 'running.dart';
import 'triangle.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);
  final AuthService _auth = AuthService();
  final wrktColor = const Color(0xFF28CCD3);
  final blackColor = const Color(0xBF000000);

  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('MotiNation '),
            backgroundColor: barColor,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: bgColor,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: bgColor),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Spacer(
                    flex: 4,
                  ),
                  Container(
                    width: 200,
                    height: 170,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Running()),
                        );
                      },
                      child: CustomPaint(
                        
                        painter: TrianglePainter(
                          strokeColor: barColor,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: 
                          Container(
                          child: Column(
                            children: [
                              Spacer(flex: 2),
                              Icon(
                            Icons.timer,
                            size: 80,
                              ),
                            Spacer(),
                          
                            ],
                          ),
                          
                          height: 170,
                          width: 200,
                        ),
                        
                      ),
                    ),
                    
                  ),
                  Spacer(),
                  Container(
                    width: 200,
                    height: 170,
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Workout()),
                        );
                      },
                      child: CustomPaint(
                        painter: TrianglePainterDown(
                          strokeColor: wrktColor,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        
                        child: Container(
                          child: Column(
                            children: [
                              Spacer(),
                              Icon(
                            Icons.fitness_center,
                            size: 80,
                              ),
                            Spacer(flex:2),
                          
                            ],
                          ),
                          height: 170,
                          width: 200,
                        ),
                        
                        ),
                      ),
                
                 
                  ),
                  Spacer(flex: 4),
                ]),
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
                if (_currentIndex == 2)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Challenge()),
                  );
                if (_currentIndex == 0)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
              });
            },
          ),
        ));
  }
}
