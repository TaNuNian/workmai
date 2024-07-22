import 'package:flutter/cupertino.dart';

class MatchingUserProvider with ChangeNotifier{
  List<String> _uids = [];

  List<String> get uids => _uids;

  void addUser(String uid) {
    if (!_uids.contains(uid)) {
      _uids.add(uid);
      notifyListeners();
    }
  }

  void removeUser(String uid) {
    if (_uids.contains(uid)) {
      _uids.remove(uid);
      notifyListeners();
    }
  }

  void clearUsers() {
    _uids.clear();
    notifyListeners();
  }
}