import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motination/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
// collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user'); //new collection if you register
//final CollectionReference activityCollection = Firestore.instance.collection('user');
  final CollectionReference spzCollection =
      Firestore.instance.collection('spz');

// Send Data

  Future updateUserData(
      String fistname,
      String lastname,
      String username,
      String height,
      String age,
      String weight,
      String uid,
      String sex,
      String sumdistanz,
      String sumtime,
      String sumspeed,
      int trackrun,
      int points) async {
    return await userCollection.document(uid).updateData({
      'fistname': fistname,
      'lastname': lastname,
      'username': username,
      'height': height,
      'age': age,
      'weight': weight,
      'uid': uid,
      'sex': sex, //neu hinzugefügt
      'sumdistanz': sumdistanz,
      'sumtime': sumtime,
      'sumspeed': sumspeed,
      'trackrun': trackrun,
      'points': points,
    });
  }

// set Data first Time on Registration
  Future setUserData(
    String firstname,
    String height,
    String age,
    String weight,
    String sex,
    String uid,
  ) async {
    return await userCollection.document(uid).setData({
      'firstname': firstname,
      'height': height,
      'age': age,
      'weight': weight,
      'sex': sex, //neu hinzugefügt
      'uid': uid,
    });
  }

  Future updateRunData(
      String distance,
      kcal,
      time,
      List<double> lat,
      List<double> lng,
      double latinit,
      double lnginit,
      String date,
      String sportType,
      int points,
      double altitudeUp,
      double altitudeDown) async {
    return await userCollection
        .document(uid)
        .collection('Run')
        .document(date)
        .setData({
      'distance': distance,
      'kcal': kcal,
      'time': time,
      'lat': lat,
      'lng': lng,
      'latinit': latinit,
      'lnginit': lnginit,
      'date': date,
      'sportType': sportType,
      'points': points,
      'altitudeUp': altitudeUp,
      'altitudeDown': altitudeDown,
    });
  }

  Future updatePoints(int points) async {
    return await userCollection.document(uid).updateData({
      'points': points,
    });
  }

    Future updateAge(String age) async {
    return await userCollection.document(uid).updateData({
      'age': age,
    });
  }

   Future updateSex(String sex) async {
    return await userCollection.document(uid).updateData({
      'sex': sex,
    });
  }

   Future updateFirstName(String firstName) async {
    return await userCollection.document(uid).updateData({
      'firstname': firstName,
    });
  }

  Future updateUserName(String userName) async {
    return await userCollection.document(uid).updateData({
      'username': userName,
    });
  }

    Future updateLastName(String lastName) async {
    return await userCollection.document(uid).updateData({
      'lastname': lastName,
    });
  }

    Future updateWeight(String weight) async {
    return await userCollection.document(uid).updateData({
      'weight': weight,
    });
  }

    Future updateSumSpeed(String sumSpeed) async {
    return await userCollection.document(uid).updateData({
      'sumspeed': sumSpeed,
    });
  }

    Future updateTrackrun(int trackrun) async {
    return await userCollection.document(uid).updateData({
      'trackrun': trackrun,
    });
  }

  Future updateHeight(String height) async {
    return await userCollection.document(uid).updateData({
      'height': height,
    });
  }
  Future updateSumDistance(String sumdistance) async {
    return await userCollection.document(uid).updateData({
      'sumdistance': sumdistance,
    });
  }

  Future updateSumTime(String sumtime) async {
    return await userCollection.document(uid).updateData({
      'sumtime': sumtime,
    });
  }



  Future setWorkoutData(String name, String date, int points) async {
    return await userCollection
        .document(uid)
        .collection('Workout')
        .document(date)
        .setData({
      'name': name,
      'date': date,
      'points': points,
    });
  }

// Get Data

//get UserData
  Future getUserData() async {
    return await userCollection.document(uid).get();
  }

// Retruns DocumentSnapshot from User from Database
  Future<DocumentSnapshot> getData(User user) async {
    try {
      DocumentSnapshot snapshot =
          await DatabaseService(uid: user.uid).getUserData();

      return snapshot;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

// Prototype gets Data from DocumentSnapshot to Variable
  void getStufffromSnapshot(DocumentSnapshot snapshot) {
    // Map<String, dynamic> data = snapshot.data;

    // var = data["nameOfFieldDocumentSnapshot"]
  }

  Map<String,dynamic> snapshot2map(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data;
    return data;
  }
//userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstname: snapshot.data['firstname'],
      lastname: snapshot.data['lastname'],
      username: snapshot['username'],
      height: snapshot.data['height'],
      age: snapshot.data['age'],
      weight: snapshot.data['weight'],
    );
  }

  

//get user data stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
