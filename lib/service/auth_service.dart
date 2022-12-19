import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../constents/error_handling.dart';
import '../models/user.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      var response = await http.post(Uri.parse('/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      log(response.statusCode.toString());
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account Created!',
          );
        },
      );
      log(response.statusCode.toString());
    } catch (e) {
      showSnackBar(context, 'server${e.toString()}');
    }
  }

//sign in
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(response.body);
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, 'server${e.toString()}');
    }
  }
}
