import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/motination.dart';
import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
// collection reference
final CollectionReference userCollection = Firestore.instance.collection('user'); //new collection if you register


Future updateUserData(String vorname, String nachname, String benutzername, String groese, String alter, String gewicht, String uid) async {
  return await userCollection.document(uid).setData({
    'vorname': vorname,
    'nachname': nachname,
    'benutzername': benutzername,
    'groese': groese,
    'alter': alter,
    'gewicht': gewicht,
    'uid': uid, //neu hinzugefügt
  });
}

//list from snapshot

/*List<MotiNation> _motinationListFromSnapshot(QuerySnapshot snapshot){
return snapshot.documents.map((doc){
  return MotiNation(
    vorname: doc.data['vorname'] ?? '-',
    nachname: doc.data['nachname'] ?? '-',
    groese: doc.data['groese'] ?? '-',
    alter: doc.data['alter'] ?? '-',

  );

}).toList();
}*/

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

//get User streams
/*Stream<List<MotiNation>> get user{
return userCollection.snapshots()
.map(_motinationListFromSnapshot);
}*/

//get user doch stream
Stream<UserData> get userData {
  return userCollection.document(uid).snapshots()
  .map(_userDataFromSnapshot);
}



}
