import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../main.dart';
import '../util/consts.dart';
import '../util/dio.dart';
import '../util/snackbar.dart';

class Auth with ChangeNotifier {
  String? _token;
  final storage = const FlutterSecureStorage();

  String? get token {
    return _token;
  }

  Future<bool> login(String token) async {
    log('login');
    // call http request to login
    try {
      Dio dio = DioExtension.get(token);
      // Dio dio = Dio();
      Response response = await dio.get('$baseUrl/core/ping');
      log('ping - call');
      log('response: ${response.statusCode}');
      if (response.statusCode == 200) {
        _token = token;
        await storage.write(key: 'token', value: _token);
        notifyListeners();
        return true;
      } else {
        log('Failed to login: ${response.statusCode}');
        if (navigatorKey.currentState != null) {
          showFailSnackBar(navigatorKey.currentContext!,
              'Failed to login: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      log('Failed to login: $e');
      if (navigatorKey.currentState != null) {
        showFailSnackBar(navigatorKey.currentContext!, 'Failed to login: $e');
      }
      return false;
    }
  }

  Future<void> logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    log('logout');
    _token = null;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    log('tryAutoLogin');
    const storage = FlutterSecureStorage();

    if (!await storage.containsKey(key: 'token')) return false;
    _token = await storage.read(key: 'token');
    notifyListeners();
    return true;
  }
}
