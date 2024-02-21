import 'package:audiadmin/models/userP.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  userP? _user;

  userP? get user => _user;

  String get displayName => _user!.displayName;
  String get uid => _user!.uid;
  String get photoURL => _user!.photoURL;
  String get token => _user!.token;
  String get organization => _user!.organization;

  void setUser(userP user) {
    this._user = user;
    notifyListeners();
  }

  void deleteUser() {
    this._user = null;
    notifyListeners();
  }

  void setDisplayName(String displayName) {
    this._user?.setDisplayName(displayName);
    notifyListeners();
  }

  void setUid(String uid) {
    this._user?.setUid(uid);
    notifyListeners();
  }

  void setPhotoURL(String photoURL) {
    this._user?.setPhotoURL(photoURL);
    notifyListeners();
  }

  void setToken(String token) {
    this._user!.setToken(token);
    notifyListeners();
  }

  void setOrganization(String organization) {
    this._user!.setOrganization(organization);
    notifyListeners();
  }
}
