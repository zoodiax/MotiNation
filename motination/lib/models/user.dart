import 'dart:ffi';

class User {

  final String uid;

  User({this.uid});
  
}

class UserData {

final String uid;
final String firstname;
final String lastname;
final int height;
final String age;
final String username;
final Double weight;
final String sex;
final String sumdistance;
final String sumtime; 
final String sumspeed; 
final int trackrun;
final int points;



UserData({this.uid, this.firstname, this.lastname, this.height, this.age, this.username, this.weight, this.sex, this.sumdistance, this.sumtime, this.sumspeed,this.trackrun, this.points});


}
