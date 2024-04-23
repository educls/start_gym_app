import 'package:flutter/foundation.dart';

class DataAppProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _token = 'token';
  String _email = 'teste@';

  String get token => _token;
  String get email => _email;

  void setToken(token) {
    _token = token;
    notifyListeners();
  }

  void setEmail(email) {
    _email = email;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('token', token));
  }
}
