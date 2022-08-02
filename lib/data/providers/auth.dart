import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_app/resources/constants.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider with ChangeNotifier {
  AuthProvider._();
  final _controller = StreamController<AuthStatus>.broadcast();
  AuthStatus _status = AuthStatus.unknown;
  String? authToken;

  Stream<AuthStatus> get stream async* {
    yield _status;
    yield* _controller.stream.asBroadcastStream();
  }

  AuthStatus get status => _status;
  login(String authToken) {
    authToken = authToken;
    _status = AuthStatus.authenticated;
    _controller.add(_status);
    notifyListeners();
  }

  logout() async {
    authToken = null;
    _status = AuthStatus.unauthenticated;
    _controller.add(_status);
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(USER_KEY);
      prefs.remove(AUTH_TOKEN_KEY);
    });
    notifyListeners();
  }

  static final instance = AuthProvider._();
}
