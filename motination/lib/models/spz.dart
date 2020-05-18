import 'package:cloud_firestore/cloud_firestore.dart';

class Spz{
  String id;
  String name;
  int lat;
  String address;

  Spz.fromMap(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    lat = data['lat'];
    address = data['address'];
  }
}