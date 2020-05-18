import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Spz {
List<Spz> allSpz = [];

  String name;
  int lat;
  int lng;
  bool gym;
  bool pool;

  Spz({this.name = 'Max Mustermann', this.lat, this.lng, this.gym, this.pool});

}

//   @override
//   Widget build(BuildContext context) {
//     return 
//       StreamBuilder(stream: Firestore.instance.collection('spz').snapshots(),
//       builder: (context, snapshot){
//         if (!snapshot.hasData) return Text('Loading data .. please wait..');
//         else{
//         return Column(children: <Widget>[
//           Text(snapshot.data.documents[1]['name']),
//           Text(snapshot.data.documents[1]['lat'].toString()),
//           Text(snapshot.data.documents[1]['address']['city']),
//         ]); }   
//       },
//     );
//   }
// }


