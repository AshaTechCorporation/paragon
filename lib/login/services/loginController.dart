import 'package:flutter/material.dart';
import 'package:paragon/login/services/loginApi.dart';
import 'package:paragon/models/auth.dart';
import 'package:paragon/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  LoginController({this.api = const LoginApi()});

  LoginApi api;
  User? user;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Auth> signIn({
    required String email,
    required String password,
    required String deviceId,
    required String notify_token
  }) async {
    final data = await LoginApi.login(email, password, deviceId, notify_token);
    final SharedPreferences prefs = await _prefs;

    final _user = data;
    user = data.data;
    await prefs.setString('token', data.token);
    await prefs.setString('permission', data.data!.type!);
    notifyListeners();
    return _user;
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await _prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user = null;   

    notifyListeners();
  }

}