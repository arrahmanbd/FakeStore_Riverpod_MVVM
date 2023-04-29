import 'package:fake_store/service/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/app_error.dart';
import '../../helper/app_exception.dart';
import '../../model/authmodel.dart';

class Auth extends ChangeNotifier {
  String authinfo = '';
  bool isLoading = false;
  UserError userError = UserError();
  bool isSuccess = false;
  String token = '';

  setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  setResponse(bool state) {
    isSuccess = state;
    notifyListeners();
  }

  Auth() {
    _loadToken();
  }

  void _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    isSuccess = (prefs.getBool('isSuccess') ?? false);
  }

  login(String email, String pass) async {
    setLoading(true);
    Map payloadObj = {
      'email': email, //'eve.holt@reqres.in',
      'password': pass, //'cityslicka',
    };
    try {
      var post = await BaseApi.post('https://reqres.in/api/login', payloadObj);
      if (post is Success) {
        token = AuthModel.fromMap(post.response as Map<String, dynamic>).token;
        if (token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('isSuccess', true);
           setResponse(true);
        }
      }
      if (post is Failure) {
        setResponse(false);
        userError =
            UserError(code: post.code, message: post.errorResponse.toString());
        setLoading(true);
      }
    } catch (e) {
      setResponse(false);
      userError = UserError(code: 999, message: e.toString());
      setLoading(true);
    }
    setLoading(false);
  }
}

final authProvider = ChangeNotifierProvider((ref) {
  return Auth();
});
