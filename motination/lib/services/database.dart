import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;
  
  DatabaseService({this.uid});
// collection reference
final CollectionReference userCollection = Firestore.instance.collection('user'); //new collection if you register
final CollectionReference spzCollection = Firestore.instance.collection('spz');


// Send Data
Future updateUserData(String vorname, String nachname, String benutzername, String groese, String alter, String gewicht, String uid, int trackrun, int points) async {
 return await userCollection.document(uid).setData({
    'vorname': vorname,
    'nachname': nachname,
    'benutzername': benutzername,
    'groese': groese,
    'alter': alter,
    'gewicht': gewicht,
    'uid': uid, //neu hinzugefügt
    'trackrun' : trackrun,
    'points' : points,
    
  });
}

Future updateRunData(String distanz, kcal, time, List<double> lat, List<double> lng, double latinit, double lnginit, String date, String sportType) async {
  return await userCollection.document(uid).collection('Run').document(date).setData({
    'distanz': distanz,
    'kcal': kcal,
    'time': time,
    'lat':lat,
    'lng':lng,
    'latinit':latinit,
    'lnginit':lnginit,
    'date' : date,
    'sportType' : sportType

    
  });
}

Future updatePoints(int points) async {
  return await userCollection.document(uid).updateData({
    'points': points,
  });
}



// Get Data

//get UserData 
Future getUserData() async {
  return await userCollection.document(uid).get();
}

// Retruns DocumentSnapshot from User from Database
 Future <DocumentSnapshot> getData(User user) async{
    try{
    DocumentSnapshot snapshot = await DatabaseService(uid: user.uid).getUserData();
    print(snapshot.data.toString());
    return snapshot; 
    }
    catch(err){
    print(err.toString());
    return null;   
    }
  }


// Prototype gets Data from DocumentSnapshot to Variable
void getStufffromSnapshot(DocumentSnapshot snapshot){
  Map<String, dynamic> data = snapshot.data;
  
  // var = data["nameOfFieldDocumentSnapshot"]
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
