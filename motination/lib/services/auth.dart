import 'package:firebase_auth/firebase_auth.dart';
import 'package:motination/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  //compare if User exists with given Mail and Passwort
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }


//auth change user stream
Stream<User> get user {
  return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
}


//sign in anon
/*
Future signInAnon() async {
  try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e) {
    print(e.toString());
    return null;

  }
}*/



// sign in with email & password
Future signInrWithEmailAndPassword(String email, String password) async {
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    //return _userFromFirebaseUser(user);

  if (user.isEmailVerified) 
    {
      print('Email is verified');
      print('Logging User in...');
      return _userFromFirebaseUser(user);
      }

    else {
      print('Email is not verified');
      return null;}
      
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
    
    await user.sendEmailVerification();
   
    return _userFromFirebaseUser(user);
  } catch(e){
    print("An error occured while trying to send email verification");
      print(e.toString());
    switch (e.code){
      
      case 'ERROR_EMAIL_ALREADY_IN_USE':
      {
        print("Mail already in use");
        return 'ERROR_EMAIL_ALREADY_IN_USE';
      }
      break;
      default: return null;
    }
    
  

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

// send new Passwort to Mail 
Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
}


}