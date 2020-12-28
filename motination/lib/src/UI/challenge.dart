
import 'package:flutter/material.dart';
import 'profile.dart';
import 'homescreen.dart';
import 'shop.dart';




import 'package:motination/services/database.dart';
import 'package:motination/models/user.dart';
import 'package:provider/provider.dart';
import 'package:motination/src/UI/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:numberpicker/numberpicker.dart';


/* Challenge Class UI Design
  Test Page for Backend Test
  Content:  Bottom Navigation Bar
  Function: MaterialPageRoute -> (Profile, Homescreen, Shop) 
*/

class Challenge extends StatefulWidget {
  final int points;

  Challenge({Key key, this.points}) : super (key:key);
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {


 
  int points = 0;
  int _currentIndex = 2;
  DateTime _dateTime = DateTime.now();  
  String _currentmale; 
  int _currentgroese = 180;
  double currentgewicht= 1.0;

  @override
  Widget build(BuildContext context) {

   User user = Provider.of<User>(context);
  
  void _showCupertinoDatePicker(BuildContext context){
    showModalBottomSheet(
      context:context,
      builder: (BuildContext context) {
        return Container(
          child: CupertinoDatePicker(
        initialDateTime: _dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (datetime){
          setState(() {
            _dateTime = datetime;     
          });
      }
     ),);
      });} 

    void _showNumberGrosePicker(BuildContext context){
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: NumberPicker.integer(
              initialValue: _currentgroese, 
              minValue: 120, 
              maxValue: 280, 
              onChanged: (currentgroese){
                setState((){
                  _currentgroese = currentgroese;
                });
              }
              ),
          );
        }
      );
    }
   
  void _showCupertinoMalePicker(BuildContext context){
    showModalBottomSheet(
      context:context,
      builder: (BuildContext context){
        return Container(
          child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: ( male){
              /*setState((){
                _currentmale = male;
              });*/
              print(male);
              if (male == 0){
                 _currentmale = 'männlich';
              
              }
              if (male == 1){
                 _currentmale ='weiblich';
              }
              if (male == 2){
                 _currentmale = 'divers';
              }
              
              
            },
            children: <Widget>[
              Text("männlich"),
              Text("weiblich"),
              Text("divers"),
            ],
          ),
        );
      }
    );
  }
  double _currentPrice = 1.0;

  void _showDialog(BuildContext context) {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPicker.decimal(
          minValue: 1,
          maxValue: 10,
          initialValue: _currentPrice,
          onChanged: (price) {
            _currentPrice = price;
          }
        );
      });
  }
/*void _showNumberGrosePicker(BuildContext context){
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            child: NumberPicker.integer(
              initialValue: _currentgroese, 
              minValue: 120, 
              maxValue: 280, 
              onChanged: (currentgroese){
                setState((){
                  _currentgroese = currentgroese;
                });
              }
              ),
          );
        }
      );
    }*/
  double currentgewicht = 80.0; 
  void _showCupertinoWeightPicker (BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return Container(
          child: NumberPicker.decimal(
          minValue: 20,
          maxValue: 200,
          initialValue: currentgewicht,
          onChanged: (_currentgewicht){
            currentgewicht = _currentgewicht;
          }
        ));
      } 
    );
  }
    /*void _showDialog() {
    showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.decimal(
          minValue: 1,
          maxValue: 10,
          title: new Text("Pick a new price"),
          initialDoubleValue: _currentPrice,
        );
      }
    ).then((int value)) {
      if (value != null) {
        setState(() => _currentPrice = value);
      }
    });
  }*/


    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Challenge'),
      ),

      body: /*FlatButton(
        onPressed:(){
          _showCupertinoDatePicker(context);
        },
        child: Text('Geburtsdatum'),
        color: Colors.blue,

      ),*/
      FlatButton(
        onPressed: (){
          _showCupertinoWeightPicker(context);
        },
        child: Text('Gewicht'),
      ),
   
/*CupertinoDatePicker(
        initialDateTime: _dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (datetime){
          setState(() {
            _dateTime = datetime;     
          }
          );
      }
     )   */   
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white
        ,
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
      ),
    );
  }
}