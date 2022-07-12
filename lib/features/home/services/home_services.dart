import 'dart:convert';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_handling.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryWiseProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    List<Product> categorizedProd = [];

    try {
      var res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProv.user.token,
        },
      );
      print(res.statusCode);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(jsonDecode(res.body).length);
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            categorizedProd.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, '${e}In Home Services');
    }
    return categorizedProd;
  }
}
