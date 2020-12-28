import 'dart:ffi';

class User {

  final String uid;

  User({this.uid});
  
}

class UserData {

final String uid;
final String vorname;
final String nachname;
final int groese;
final String alter;
final String benutzername;
final Double gewicht;
final String geschlecht;
final String sumdistanz;
final String sumtime; 
final String sumspeed; 
final int trackrun;
final int points;



UserData({this.uid, this.vorname, this.nachname, this.groese, this.alter, this.benutzername, this.gewicht, this.geschlecht, this.sumdistanz, this.sumtime, this.sumspeed,this.trackrun, this.points});


}
