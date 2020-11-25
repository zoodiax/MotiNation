import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;
  
  DatabaseService({this.uid});
// collection reference
final CollectionReference userCollection = Firestore.instance.collection('user'); //new collection if you register
final CollectionReference activityCollection = Firestore.instance.collection('user');
final CollectionReference spzCollection = Firestore.instance.collection('spz');

Future updateUserData(String vorname, String nachname, String benutzername, String groese, String alter, String gewicht, String uid, String geschlecht, int trackrun, String sumdistanz, String sumtime, String sumspeed,) async {
  return await userCollection.document(uid).setData({
    'vorname': vorname,
    'nachname': nachname,
    'benutzername': benutzername,
    'groese': groese,
    'alter': alter,
    'gewicht': gewicht,
    'uid': uid,
    'geschlecht': geschlecht, //neu hinzugefügt
    'trackrun' : trackrun,
  });
}

Future updateRunData(String distanz, kcal, time, List<double> lat, List<double> lng, double latinit, double lnginit, String date) async {
  return await userCollection.document(uid).collection('Run').document(date).setData({
    'distanz': distanz,
    'kcal': kcal,
    'time': time,
    'lat':lat,
    'lng':lng,
    'latinit':latinit,
    'lnginit':lnginit,
    'date' : date,

    
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


//get user doch stream
//get user data stream
Stream<UserData> get userData {
  return userCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}



}
