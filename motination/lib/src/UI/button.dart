import 'dart:ui';
import 'package:motination/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:motination/services/auth.dart';
import 'package:motination/src/UI/OldButGold/challenge.dart';

import 'Workout/workout.dart';
import 'profile.dart';
import 'shop.dart';
import 'Run/running.dart';
import 'OldButGold/triangle.dart';

class Button extends StatefulWidget {
  @override
  createState() {
    return _ButtonState();
  }
}

class _ButtonState extends State<Button> {
  int _currentIndex = 1;
  final barColor = const Color(0xFF0A79DF);
  //final bgColor = const Color(0xFFFEFDFD);
  final AuthService _auth = AuthService();
  //final wrktColor = const Color(0xFF28CCD3);
  //final blackColor = const Color(0xBF000000);

  //final blue = const Color(0xff191970);
  //final orange = const Color(0xFFff9a00);



Widget _info() {
    return Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.black, width: 2),
        //   shape: BoxShape.circle,
        //   color: bgColor,
        // ),
        child: RawMaterialButton(onPressed: null,
        child: Icon(Icons.info_outline, size: 30,)
        
        ));
  }


  Widget build(context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Motination ',
                style: GoogleFonts.spartan(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
            backgroundColor: bgColor,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: bgColor,
                ),
                label: Text(
                  'Logout',
                  style: GoogleFonts.spartan(
                      textStyle: TextStyle(color: Colors.black)),
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
                    flex: 13,
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
                          strokeColor: blue,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Spacer(flex: 4),
                              Icon(
                                Icons.timer,
                                size: 80,
                                color: bgColor,
                              ),
                              Text('Running',
                                  style: GoogleFonts.spartan(
                                      textStyle: TextStyle(
                                          color: bgColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300))),
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
                          strokeColor: orange,
                          strokeWidth: 10,
                          paintingStyle: PaintingStyle.fill,
                        ),
                        child: Container(
                          child: Column(
                            children: [
                              Spacer(),
                              Text('Workout',
                                  style: GoogleFonts.spartan(
                                      textStyle: TextStyle(
                                          color: bgColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300))),
                              Icon(
                                Icons.fitness_center,
                                size: 80,
                                color: bgColor,
                              ),
                              Spacer(flex: 4),
                            ],
                          ),
                          height: 170,
                          width: 200,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 13),
                ]),
          ),
          floatingActionButton: _info(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: blue,
                ),
                label: 
                  'Home',
                  
                
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Challenge',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Shop',
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
