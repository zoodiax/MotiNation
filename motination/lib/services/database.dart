import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
// collection reference
final CollectionReference userCollection = Firestore.instance.collection('user'); //new collection if you register
final CollectionReference activityCollection = Firestore.instance.collection('user');

Future updateUserData(String vorname, String nachname, String benutzername, String groese, String alter, String gewicht, String uid, String geschlecht) async {
  return await userCollection.document(uid).setData({
    'vorname': vorname,
    'nachname': nachname,
    'benutzername': benutzername,
    'groese': groese,
    'alter': alter,
    'gewicht': gewicht,
    'uid': uid,
    'geschlecht': geschlecht, //neu hinzugefügt nochmals in Firestore überprüfen
  });
}
Future updateUserActivityData(String duration, distance, calories, date, time) async {
  return await activityCollection.document(uid).collection('workout').document('workoutid').setData({
    'duration': duration,
    'distance': distance,
    'calories': calories,
    'date': date,
    'time': time
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
Stream<UserData> get userData {
  return userCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}



}
