import 'package:flutter/foundation.dart';

import '../../models/users/ModelUserInfos.dart';

class DataAppProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _token = 'token';
  late ModelUserInfos _userInfos;

  String get token => _token;
  ModelUserInfos get userInfos => _userInfos;

  void setUserInfos(userInfos) {
    _userInfos = userInfos;
    notifyListeners();
  }

  void setToken(token) {
    _token = token;
    notifyListeners();
  }

  void setName(name) {
    userInfos.name = name;
    notifyListeners();
  }

  void setPhoto(photobase64) {
    userInfos.photo = photobase64;
    notifyListeners();
  }

  void setNumWhats(numWhats) {
    userInfos.numberwhats = numWhats;
    notifyListeners();
  }

  void setEmail(email) {
    userInfos.email = email;
    notifyListeners();
  }
  
  void setPassword(password) {
    userInfos.password = password;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', token));
  }
}
