import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  // build for int, also works for double, String and bool
  // works with <key, value> pairs

  // Saving int value

  /*Keys: 
  String intKey : "status" : status about user registration (in SignUp.dart and SignIn.dart)
      case intValue = 0: user registrated and mail verification klicket -> straigth to Running.dart
      case intValue = 1: user registrated and first time to app -> to firstTime.dart
*/

  Future addIntToSP(String intKey, int intValue) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(intKey, intValue);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Reading int value
  Future getIntValuesSP(String intKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return int
      int intValue = prefs.getInt(intKey) ?? 0;
      return intValue;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // remove int value
  Future removeValues(String intKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(intKey);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //check if value is present or not - containsKey will return true if persistent storage contains the given key and false if not.
   Future checkValues(String intKey) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool checkValue = prefs.containsKey(intKey);
      return checkValue;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}


  // String intKey = "status";
  // int intValue = 14;
  // dynamic flag;
  // final SharedPref _shared = SharedPref();
 
  // flag = await _shared.checkValues(intKey); 
  // print(flag);
  // _shared.addIntToSP(intKey, intValue);
  // flag = await _shared.checkValues(intKey);
  // print(flag);
  // flag = await _shared.getIntValuesSP(intKey);
  // print(flag);
  //  _shared.addIntToSP(intKey, 15);
  //  flag = await _shared.getIntValuesSP(intKey);
  // print(flag);
  // flag = await _shared.removeValues(intKey);
  // print(flag);
