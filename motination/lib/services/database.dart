import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;
  
  DatabaseService({this.uid});
// collection reference
final CollectionReference userCollection = Firestore.instance.collection('user'); //new collection if you register
final CollectionReference spzCollection = Firestore.instance.collection('spz');


Future updateUserData(String vorname, String nachname, String benutzername, String groese, String alter, String gewicht, String uid, int trackrun) async {
  return await userCollection.document(uid).setData({
    'vorname': vorname,
    'nachname': nachname,
    'benutzername': benutzername,
    'groese': groese,
    'alter': alter,
    'gewicht': gewicht,
    'uid': uid, //neu hinzugefügt
    'trackrun' : trackrun,
  });
}

Future updateRunData(String distanz, kcal, time, List<double> lat, List<double> lng, double latinit, double lnginit) async {
  return await userCollection.document(uid).collection('Run').add({
    'distanz': distanz,
    'kcal': kcal,
    'time': time,
    'lat':lat,
    'lng':lng,
    'latinit':latinit,
    'lnginit':lnginit,

    
  });
}




//userData from snapshot

UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
return UserData(
  uid: uid,
  vorname: snapshot.data['vorname'],
  nachname: snapshot.data['nachname'],
  benutzername: snapshot['benutzername'],
  groese: snapshot.data['groese'],
  alter: snapshot.data['alter'],
  gewicht: snapshot.data['gewicht'],
);
}


//get user data stream
Stream<UserData> get userData {
  return userCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}



}
