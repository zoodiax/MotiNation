import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:motination/models/spz.dart';

class SpzNotifier extends ChangeNotifier{
  List<Spz> _spzList = [];
  Spz _currentSpz;

  UnmodifiableListView<Spz> get spzlist => UnmodifiableListView(_spzList);
  Spz get currentSpz => _currentSpz;

  set spzList(List<Spz> spzList){
    _spzList = spzList;
    notifyListeners();
  }

  set currentSpz(Spz spz){
    _currentSpz = spz;
    notifyListeners();
  }
}