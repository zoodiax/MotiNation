import 'package:firebase_auth/firebase_auth.dart';
import 'package:motination/models/user.dart';
import 'package:motination/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
 
 DateTime currentdate = DateTime.now();
 //String stringdate;

  //compare if User exists with given Mail and Passwort
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

String randerdate(date){
  return date.substring (0,10);
}

//auth change user stream
Stream<User> get user {
  return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
}




// sign in with email & password
Future signInrWithEmailAndPassword(String email, String password) async {
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e){
    print(e.toString());
    return null;
  }
}

// register with email & password
Future registerWithEmailAndPassword(String email, String password) async {
  try{
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;


    //create a new document (in firestore) for the user with the uid  //Wird aber nur angelegt wenn man sich neu registriert, dh. wenn ein neues Update herausgebracht wird mit neuer Collection wird es nicht hinzugefügt.
    await DatabaseService(uid: user.uid).updateUserData( 'Vorname', 'Nachname' ,'benutzername', 180, '-', 80.0,user.uid,'-','0','0','0',0 ,0);
    //await DatabaseService(uid: user.uid).updateUserActivityData('duration', 'distance', 'calories', 'date', 'time'); //nur Test aber normalerweise bei start running implementieren
    return _userFromFirebaseUser(user);
  } catch(e){
    print(e.toString());
    return null;
  }
}
// sign out
Future signOut() async {
  try {
    return await _auth.signOut();
  } catch(e){
    print(e.toString());
    return null;

  }
}

}