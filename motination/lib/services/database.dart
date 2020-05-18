import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/motination.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
// collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('mNUser'); //new collection if you register


  Future updateUserData(String name, int alter, int punkte) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'alter': alter,
      'punkte': punkte,
    });
  }

//list from snapshot

  List<MotiNation> _motinationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return MotiNation(
        name: doc.data['name'] ?? '',
        alter: doc.data['alter'] ?? 0,
        punkte: doc.data['punkte'] ?? 0,
      );
    }).toList();
  }

//get User streams
  Stream<List<MotiNation>> get mNUser {
    return userCollection.snapshots().map(_motinationListFromSnapshot);
  }
}
