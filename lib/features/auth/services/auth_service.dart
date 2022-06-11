/*
 -> Connects the backend with flutter using http requests
*/
import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import '../../../constants/global_variables.dart';

class AuthService {
  // SignUp Method
  void SignUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Copy this line everytime you use http
        },
      );

      /// Our own Error Handler [lib/constants/error_handling.dart]
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! Login with the same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // SignIn Method
  void SignInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Copy this line everytime you use http
        },
      );
      // print(res.body);  ->  res.body is a STRING {! ALWAYS KNOWING THE TYPE IS IMPORTANY}.
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // OBTAIN A OBJECT
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomNavBar.routeName,
            (route) => false,
          );
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get User Data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

      if (token == null) {
        pref.setString('x-auth-tokne', '');
      }

      var tokenRes = await http
          .post(Uri.parse("$uri/tokenIsValid"), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      });

      var response = jsonDecode(tokenRes.body);
      // Why cmparing with bool value? becuase that's what we have passed in our API(/tokenIsValid) as res.json(true)/(false)
      if (response == true) {
        // get user data -> create your API to get that
        var userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (e) {}
  }
}
