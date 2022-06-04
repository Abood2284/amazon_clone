import 'dart:convert';

import '/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context,
        json.decode(response.body)['msg'],
      ); // why 'msg' -> becoz u r only returning json format msg on 400 status code in auth.js
      break;
    case 500:
      showSnackBar(
        context,
        json.decode(response.body)['erro'],
      );
      break;
    default:
      showSnackBar(context, response.body);
  }
}
