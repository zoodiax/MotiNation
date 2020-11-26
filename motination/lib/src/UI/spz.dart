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


