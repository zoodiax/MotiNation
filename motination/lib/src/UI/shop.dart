import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motination/models/user.dart';
import 'package:motination/services/database.dart';
import 'package:motination/shared/loading.dart';
import 'package:motination/src/UI/challenge.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:motination/services/database.dart';

class Shoping extends StatefulWidget { 
  final String uid;

  const Shoping({Key key, this.uid}) : super(key: key);
  @override
  createState() {
    return ShopState();

  }
}

class ShopState extends State<Shoping> {
  final _formKey = GlobalKey<FormState>();
  //final CollectionReference activityCollection = Firestore.instance.collection('user');

  //String timer;
  //String _currenttimmer

  int _currentIndex = 3;
  final barColor = const Color(0xFF0A79DF);
  final bgColor = const Color(0xFFFEFDFD);  

  @override
  Widget build(context) {
    User user = Provider.of<User>(context);
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Shop'),
        backgroundColor: barColor,
      ),
      /*body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: RaisedButton(
        onPressed: () Future updateUserActivityData(String duration, distance, calories, date, time) async {
  return await activityCollection.document(uid).collection('workout').document('workoutid').setData({
    'duration': duration,
    'distance': distance,
    'calories': calories,
    'date': date,
    'time': time
  });
}
async {
          if (_formKey.currentState.validate()) {
            await DatabaseService(uid: user.uid)
              .updateUserActivityData(
                _currenttimer ?? userData.timer,
              );
          }
        }
      ),
      );
        }
        else 
        return Loading();
      
          },
      ),
      
*/
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

/*class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      onPressed: callback,
      child: Text(text),
    );
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: 
          me ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
          ),
          Material(
            color: me ? Colors.teal : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal:15.0),
              child: Text(
                text,                
              ),
            )
          )
        ],
      ),
      
    );
  }
}*/